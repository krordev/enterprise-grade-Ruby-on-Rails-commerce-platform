require 'test_helper'

module Workarea
  class Shipping
    class ServiceTest < TestCase
      def test_rate_tier_validation
        method = create_shipping_service
        method.rates = [{ price: 1.to_m }, { price: 5.to_m }]

        refute(method.valid?)
        assert(method.errors[:rates].present?)
      end

      def test_find_rate
        shipping_service = create_shipping_service

        rate = shipping_service.rates.first
        assert_equal(rate.id, shipping_service.find_rate.id)
        assert_equal(rate.id, shipping_service.find_rate(3.to_m).id)

        shipping_service =
          create_shipping_service.tap do |method|
            method.rates = []
            method.rates.build(price: 4.to_m, tier_min: 0, tier_max: 5)
            method.rates.build(price: 3.to_m, tier_min: 5, tier_max: 7)
            method.rates.build(price: 2.to_m, tier_min: 7, tier_max: nil)
            method.save!
          end

        assert_equal(4.to_m, shipping_service.find_rate.price)
        assert_equal(4.to_m, shipping_service.find_rate(2.to_m).price)
        assert_equal(4.to_m, shipping_service.find_rate(5.to_m).price)

        assert_equal(3.to_m, shipping_service.find_rate(6.to_m).price)
        assert_equal(3.to_m, shipping_service.find_rate(7.to_m).price)
        assert_equal(2.to_m, shipping_service.find_rate(10.to_m).price)
      end
    end
  end
end
