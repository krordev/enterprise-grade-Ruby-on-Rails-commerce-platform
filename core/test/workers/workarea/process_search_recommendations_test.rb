require 'test_helper'

module Workarea
  class ProcessSearchRecommendationsTest < Workarea::TestCase
    def test_processing_user_activity
      Recommendation::UserActivity.create!(searches: %w(foo bars))
      Recommendation::UserActivity.create!(searches: %w(foo @#$%))
      2.times { Recommendation::UserActivity.create!(searches: %w(foos baz)) }

      ProcessSearchRecommendations.new.perform

      predictor = Recommendation::SearchPredictor.new
      assert_equal(%w(baz bar), predictor.similarities_for('foo'))
    end

    def test_within_expiration
      Recommendation::UserActivity.create!(searches: %w(1 2))
      travel_to((Workarea.config.recommendation_expiration + 1.day).from_now)
      2.times { Recommendation::UserActivity.create!(searches: %w(1 3)) }

      ProcessSearchRecommendations.new.perform

      predictor = Recommendation::SearchPredictor.new
      assert_equal(%w(3), predictor.similarities_for('1'))
    end
  end
end
