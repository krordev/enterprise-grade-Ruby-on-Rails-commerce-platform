require 'test_helper'

module Workarea
  class Shipping
    class SkuTest < Workarea::TestCase
      def test_length_units
        sku = create_shipping_sku

        Workarea.with_config do |config|
          config.shipping_options = { units: :imperial }
          assert_equal(:inches, sku.length_units)

          config.shipping_options = { units: :metric }
          assert_equal(:centimeters, sku.length_units)
        end
      end

      def test_weight_units
        sku = create_shipping_sku

        Workarea.with_config do |config|
          config.shipping_options = { units: :imperial }
          assert_equal(:ounces, sku.weight_units)

          config.shipping_options = { units: :metric }
          assert_equal(:grams, sku.weight_units)
        end
      end
    end
  end
end
