module Workarea
  module Insights
    class TrendingSearches < Base
      class << self
        def dashboards
          %w(search)
        end

        def generate_monthly!
          results = generate_results.map { |r| r.merge(query_id: r['_id']) }
          create!(results: results) if results.present?
        end

        def generate_results
          Metrics::SearchByWeek
            .collection
            .aggregate([filter_date_range, group_by_query, add_improving_weeks, sort, limit])
            .to_a
        end

        def filter_date_range
          {
            '$match' => {
              'reporting_on' => {
                '$gte' => beginning_of_last_month,
                '$lte' => end_of_last_month
              }
            }
          }
        end

        def group_by_query
          {
            '$group' => {
              '_id' => '$query_id',
              'improving_weeks' => { '$sum' => 1 },
              'revenue_changes' => { '$push' => '$revenue_change' },
              'orders' => { '$sum' => '$orders' }
            }
          }
        end

        def add_improving_weeks
          {
            '$addFields' => {
              'improving_weeks' => {
                '$size' => {
                  '$filter' => {
                    'input' => '$revenue_changes',
                    'as' => 'revenue_change',
                    'cond' => { '$gt' => ['$$revenue_change', 0] }
                  }
                }
              }
            }
          }
        end

        def sort
          { '$sort' => { 'improving_weeks' => -1, 'orders' => -1 } }
        end

        def limit
          { '$limit' => Workarea.config.insights_searches_list_max_results }
        end
      end
    end
  end
end
