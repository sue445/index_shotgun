module IndexShotgun
  module Analyzer
    require "index_shotgun/array_start_with"

    class << self
      using IndexShotgun::ArrayStartWith

      EXCLUDE_TABLES = %w(ar_internal_metadata schema_migrations)

      # Search duplicate index
      # @return [String] result message
      def perform
        tables =
          ActiveSupport::Deprecation.silence do
            ActiveRecord::Base.connection.tables
          end
        tables.reject! { |table| EXCLUDE_TABLES.include?(table) }

        duplicate_indexes =
          tables.each_with_object([]) do |table, array|
            response = check_indexes(table)
            array.push(*response)
          end

        message =
          duplicate_indexes.each_with_object("") do |info, message|
            message << <<-EOS.strip_heredoc
              # =============================
              # #{info[:index].table}
              # =============================

              # #{info[:result]}
              # To remove this duplicate index, execute:
              ALTER TABLE `#{info[:index].table}` DROP INDEX `#{info[:index].name}`;

            EOS
          end

        total_index_count = tables.map { |table| table_indexes(table).count }.sum
        message << <<-EOS.strip_heredoc
          # ########################################################################
          # Summary of indexes
          # ########################################################################

          # Total Duplicate Indexes  #{duplicate_indexes.count}
          # Total Indexes            #{total_index_count}
          # Total Tables             #{tables.count}

        EOS

        message
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
    end
  end
end
