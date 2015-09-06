module IndexShotgun
  module Analyzer
    require "index_shotgun/array_start_with"

    class << self
      using IndexShotgun::ArrayStartWith

      def check_indexes(table)
        indexes = table_indexes(table)

        indexes.permutation(2).each_with_object([]) do |(source_index, target_index), response|
          next unless source_index.columns.start_with?(target_index.columns)

          if target_index.unique
            last_column = source_index.columns.last
            response << {
              index:  source_index,
              result: "#{source_index.name} has unnecessary column #{last_column} (#{target_index.name} is unique index!)",
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
