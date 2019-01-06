module IndexShotgun
  module Analyzer # rubocop:disable Metrics/ModuleLength
    require "index_shotgun/array_start_with"

    class Response
      attr_accessor :message, :duplicate_index_count, :total_index_count, :total_table_count

      def successful?
        duplicate_index_count == 0
      end

      def exit_if_failure!
        exit(1) unless successful?
      end
    end

    class << self
      using IndexShotgun::ArrayStartWith

      # Search duplicate index
      # @return [IndexShotgun::Analyzer::Response]
      def perform
        tables =
          ActiveSupport::Deprecation.silence do
            ActiveRecord::Base.connection.tables
          end
        tables.reject! {|table| exclude_tables.include?(table.downcase) }

        duplicate_indexes =
          tables.each_with_object([]) do |table, array|
            response = check_indexes(table)
            array.push(*response)
          end

        message =
          duplicate_indexes.each_with_object("") do |info, str|
            str << <<~MSG
              # =============================
              # #{info[:index].table}
              # =============================

              # #{info[:result]}
              # To remove this duplicate index, execute:
              ALTER TABLE `#{info[:index].table}` DROP INDEX `#{info[:index].name}`;

            MSG
          end

        total_index_count = tables.map {|table| table_indexes(table).count }.sum
        message << <<~MSG
          # ########################################################################
          # Summary of indexes
          # ########################################################################

          # Total Duplicate Indexes  #{duplicate_indexes.count}
          # Total Indexes            #{total_index_count}
          # Total Tables             #{tables.count}

        MSG

        response = Response.new
        response.duplicate_index_count = duplicate_indexes.count
        response.message               = message
        response.total_index_count     = total_index_count
        response.total_table_count     = tables.count

        response
      end

      # check duplicate indexes of table
      # @param table [String] table name
      # @return [Array<Hash>] array of index info
      #   index: index info {ActiveRecord::ConnectionAdapters::IndexDefinition}
      #   result: search result message
      def check_indexes(table)
        indexes = table_indexes(table)

        indexes.permutation(2).each_with_object([]) do |(source_index, target_index), response|
          next unless source_index.columns.start_with?(target_index.columns)

          if target_index.unique
            response << {
              index:  source_index,
              result: "#{source_index.name} has column(s) on the right side of unique index (#{target_index.name}). You can drop if low cardinality",
            }
          else
            response << {
              index:  target_index,
              result: "#{target_index.name} is a left-prefix of #{source_index.name}",
            }
          end
        end
      end

      # get indexes of table
      # @param table [String]
      # @see [ActiveRecord::ConnectionAdapters::TableDefinition#indexes]
      def table_indexes(table)
        ActiveRecord::Base.connection.indexes(table)
      end

      ORACLE_SYSTEM_TABLES = %w[
        AQ$DEF$_AQCALL
        AQ$DEF$_AQERROR
        AQ$_DEF$_AQCALL_F
        AQ$_DEF$_AQERROR_F
        AQ$_INTERNET_AGENTS
        AQ$_INTERNET_AGENT_PRIVS
        AQ$_QUEUES
        AQ$_QUEUE_TABLES
        AQ$_SCHEDULES
        CATALOG
        COL
        DEF$_AQCALL
        DEF$_AQERROR
        DEF$_CALLDEST
        DEF$_DEFAULTDEST
        DEF$_DESTINATION
        DEF$_ERROR
        DEF$_LOB
        DEF$_ORIGIN
        DEF$_PROPAGATOR
        DEF$_PUSHED_TRANSACTIONS
        HELP
        LOGMNRC_DBNAME_UID_MAP
        LOGMNRC_GSBA
        LOGMNRC_GSII
        LOGMNRC_GTCS
        LOGMNRC_GTLO
        LOGMNRP_CTAS_PART_MAP
        LOGMNRT_MDDL$
        LOGMNR_AGE_SPILL$
        LOGMNR_ATTRCOL$
        LOGMNR_ATTRIBUTE$
        LOGMNR_CCOL$
        LOGMNR_CDEF$
        LOGMNR_COL$
        LOGMNR_COLTYPE$
        LOGMNR_DICTIONARY$
        LOGMNR_DICTSTATE$
        LOGMNR_ENC$
        LOGMNR_ERROR$
        LOGMNR_FILTER$
        LOGMNR_GLOBAL$
        LOGMNR_GT_TAB_INCLUDE$
        LOGMNR_GT_USER_INCLUDE$
        LOGMNR_GT_XID_INCLUDE$
        LOGMNR_ICOL$
        LOGMNR_IND$
        LOGMNR_INDCOMPART$
        LOGMNR_INDPART$
        LOGMNR_INDSUBPART$
        LOGMNR_INTEGRATED_SPILL$
        LOGMNR_KOPM$
        LOGMNR_LOB$
        LOGMNR_LOBFRAG$
        LOGMNR_LOG$
        LOGMNR_LOGMNR_BUILDLOG
        LOGMNR_NTAB$
        LOGMNR_OBJ$
        LOGMNR_OPQTYPE$
        LOGMNR_PARAMETER$
        LOGMNR_PARTOBJ$
        LOGMNR_PROCESSED_LOG$
        LOGMNR_PROPS$
        LOGMNR_REFCON$
        LOGMNR_RESTART_CKPT$
        LOGMNR_RESTART_CKPT_TXINFO$
        LOGMNR_SEED$
        LOGMNR_SESSION$
        LOGMNR_SESSION_ACTIONS$
        LOGMNR_SESSION_EVOLVE$
        LOGMNR_SPILL$
        LOGMNR_SUBCOLTYPE$
        LOGMNR_TAB$
        LOGMNR_TABCOMPART$
        LOGMNR_TABPART$
        LOGMNR_TABSUBPART$
        LOGMNR_TS$
        LOGMNR_TYPE$
        LOGMNR_UID$
        LOGMNR_USER$
        LOGSTDBY$APPLY_MILESTONE
        LOGSTDBY$APPLY_PROGRESS
        LOGSTDBY$EDS_TABLES
        LOGSTDBY$EVENTS
        LOGSTDBY$FLASHBACK_SCN
        LOGSTDBY$HISTORY
        LOGSTDBY$PARAMETERS
        LOGSTDBY$PLSQL
        LOGSTDBY$SCN
        LOGSTDBY$SKIP
        LOGSTDBY$SKIP_SUPPORT
        LOGSTDBY$SKIP_TRANSACTION
        MVIEW$_ADV_AJG
        MVIEW$_ADV_BASETABLE
        MVIEW$_ADV_CLIQUE
        MVIEW$_ADV_ELIGIBLE
        MVIEW$_ADV_EXCEPTIONS
        MVIEW$_ADV_FILTER
        MVIEW$_ADV_FILTERINSTANCE
        MVIEW$_ADV_FJG
        MVIEW$_ADV_GC
        MVIEW$_ADV_INFO
        MVIEW$_ADV_JOURNAL
        MVIEW$_ADV_LEVEL
        MVIEW$_ADV_LOG
        MVIEW$_ADV_OUTPUT
        MVIEW$_ADV_PARAMETERS
        MVIEW$_ADV_PLAN
        MVIEW$_ADV_PRETTY
        MVIEW$_ADV_ROLLUP
        MVIEW$_ADV_SQLDEPEND
        MVIEW$_ADV_TEMP
        MVIEW$_ADV_WORKLOAD
        MVIEW_EVALUATIONS
        MVIEW_EXCEPTIONS
        MVIEW_FILTER
        MVIEW_FILTERINSTANCE
        MVIEW_LOG
        MVIEW_RECOMMENDATIONS
        MVIEW_WORKLOAD
        OL$
        OL$HINTS
        OL$NODES
        PRODUCT_PRIVS
        PRODUCT_USER_PROFILE
        PUBLICSYN
        REPCAT$_AUDIT_ATTRIBUTE
        REPCAT$_AUDIT_COLUMN
        REPCAT$_COLUMN_GROUP
        REPCAT$_CONFLICT
        REPCAT$_DDL
        REPCAT$_EXCEPTIONS
        REPCAT$_EXTENSION
        REPCAT$_FLAVORS
        REPCAT$_FLAVOR_OBJECTS
        REPCAT$_GENERATED
        REPCAT$_GROUPED_COLUMN
        REPCAT$_INSTANTIATION_DDL
        REPCAT$_KEY_COLUMNS
        REPCAT$_OBJECT_PARMS
        REPCAT$_OBJECT_TYPES
        REPCAT$_PARAMETER_COLUMN
        REPCAT$_PRIORITY
        REPCAT$_PRIORITY_GROUP
        REPCAT$_REFRESH_TEMPLATES
        REPCAT$_REPCAT
        REPCAT$_REPCATLOG
        REPCAT$_REPCOLUMN
        REPCAT$_REPGROUP_PRIVS
        REPCAT$_REPOBJECT
        REPCAT$_REPPROP
        REPCAT$_REPSCHEMA
        REPCAT$_RESOLUTION
        REPCAT$_RESOLUTION_METHOD
        REPCAT$_RESOLUTION_STATISTICS
        REPCAT$_RESOL_STATS_CONTROL
        REPCAT$_RUNTIME_PARMS
        REPCAT$_SITES_NEW
        REPCAT$_SITE_OBJECTS
        REPCAT$_SNAPGROUP
        REPCAT$_TEMPLATE_OBJECTS
        REPCAT$_TEMPLATE_PARMS
        REPCAT$_TEMPLATE_REFGROUPS
        REPCAT$_TEMPLATE_SITES
        REPCAT$_TEMPLATE_STATUS
        REPCAT$_TEMPLATE_TARGETS
        REPCAT$_TEMPLATE_TYPES
        REPCAT$_USER_AUTHORIZATIONS
        REPCAT$_USER_PARM_VALUES
        SQLPLUS_PRODUCT_PROFILE
        SYSCATALOG
        SYSFILES
        TAB
        TABQUOTAS
      ].freeze

      def exclude_tables
        return @exclude_tables if @exclude_tables

        # Rails default tables
        tables = %w[ar_internal_metadata schema_migrations]

        # Oracle system tables
        tables += ORACLE_SYSTEM_TABLES

        @exclude_tables = tables.map(&:downcase)
        @exclude_tables
      end
    end
  end
end
