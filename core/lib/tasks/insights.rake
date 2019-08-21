require 'active_support/testing/time_helpers'

namespace :workarea do
  namespace :insights do
    desc 'Creates metrics and insights based on orders'
    task generate: :environment do
      include ActiveSupport::Testing::TimeHelpers
      batch_size = ENV['WORKAREA_INSIGHTS_BATCH_SIZE'].presence || 1000

      Workarea::Order
        .placed
        .each_by(batch_size.to_i) { |o| Workarea::SaveOrderMetrics.perform(o) }

      8.times do |i|
        travel_to (i.weeks.ago.beginning_of_week + 1.hour)
        Workarea::GenerateInsights.generate_all!
      end

      puts "Success! Generated #{Workarea::Insights::Base.count} insights."
    end

    # Clear the metrics/insights environment - deletes lots of data, this task
    # is very dangerous! Useful for testing/debugging.
    task reset: :environment do
      Workarea::Order
        .where(:metrics_saved_at.gt => 0)
        .update_all(metrics_saved_at: nil)


      Workarea::Metrics::CategoryByDay.delete_all
      Workarea::Metrics::CountryByDay.delete_all
      Workarea::Metrics::DiscountByDay.delete_all
      Workarea::Metrics::MenuByDay.delete_all
      Workarea::Metrics::ProductByDay.delete_all
      Workarea::Metrics::ProductByWeek.delete_all
      Workarea::Metrics::ProductForLastWeek.delete_all
      Workarea::Metrics::SalesByDay.delete_all
      Workarea::Metrics::SearchByDay.delete_all
      Workarea::Metrics::SearchByWeek.delete_all
      Workarea::Metrics::SearchForLastWeek.delete_all
      Workarea::Metrics::SkuByDay.delete_all
      Workarea::Metrics::TrafficReferrerByDay.delete_all
      Workarea::Metrics::User.delete_all
      Workarea::Insights::Base.delete_all

      puts "Success! Insights and metrics have been cleared."
    end
  end
end
