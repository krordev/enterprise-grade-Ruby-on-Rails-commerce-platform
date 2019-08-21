require 'test_helper'

module Workarea
  module Search
    class PaginationTest < TestCase
      include TestCase::SearchIndexing

      class Paginate
        include Query
        include Pagination
        document Search::Storefront
      end

      def test_page
        assert_equal(1, Paginate.new.page)
        assert_equal(2, Paginate.new(page: 2).page)
        assert_equal(1, Paginate.new(page: -1).page)
        assert_equal(1, Paginate.new(page: 0).page)
        assert_equal(1, Paginate.new(page: 'asdf').page)
      end

      def test_from
        Workarea.with_config do |config|
          config.per_page = 30
          assert_equal(0, Paginate.new(page: 1).from)
        end

        Workarea.with_config do |config|
          config.per_page = 15
          assert_equal(15, Paginate.new(page: 2).from)
        end

        Workarea.with_config do |config|
          config.per_page = 45
          assert_equal(90, Paginate.new(page: 3).from)
        end
      end

      def test_size
        Workarea.with_config do |config|
          config.per_page = 30

          search = Paginate.new(page: 2)
          assert_equal(30, search.size)
        end
      end

      def test_each_by
        product_one = create_product(name: 'Foo 1')
        product_two = create_product(name: 'Foo 2')

        IndexProduct.perform(product_one)
        IndexProduct.perform(product_two)

        [1, 2, 3].each do |by|
          calls = []
          Paginate.new(q: 'foo').each_by(by) { |p| calls << p }

          assert_equal(2, calls.size)
          assert(calls.include?(product_one))
          assert(calls.include?(product_two))
        end
      end
    end
  end
end
