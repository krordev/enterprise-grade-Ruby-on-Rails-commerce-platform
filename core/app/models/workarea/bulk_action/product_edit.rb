module Workarea
  class BulkAction
    class ProductEdit < BulkAction
      field :settings, type: Hash, default: {}
      field :add_tags, type: Array, default: []
      field :remove_tags, type: Array, default: []
      field :add_filters, type: Array, default: []
      field :remove_filters, type: Array, default: []
      field :add_details, type: Array, default: []
      field :remove_details, type: Array, default: []
      field :pricing, type: Hash, default: {}
      field :inventory, type: Hash, default: {}
      field :release_id, type: String

      list_field :add_tags
      list_field :remove_tags
      list_field :remove_filters
      list_field :remove_details

      def act_on!(product)
        Release.with_current(release_id) do
          apply_tags!(product)
          apply_filters!(product)
          apply_details!(product)
          apply_pricing!(product)
          apply_inventory!(product)

          product.update_attributes!(settings)
        end
      end

      def apply_tags!(product)
        TagUpdate
          .new(adds: add_tags, removes: remove_tags)
          .apply(product.tags)
      end

      def apply_details!(product)
        HashUpdate
          .new(adds: add_details, removes: remove_details)
          .apply(product.details)
      end

      def apply_filters!(product)
        HashUpdate
          .new(adds: add_filters, removes: remove_filters)
          .apply(product.filters)
      end

      def apply_pricing!(product)
        return unless pricing.present?

        pricing_skus(product).each do |sku|
          sku_pricing = pricing.dup
          prices = sku_pricing.delete('prices') unless sku.prices.blank?
          sku.update_attributes!(sku_pricing)

          if prices.present?
            sku.prices.select(&:generic?).each do |price|
              price.update_attributes!(prices.first)
            end
          end
        end
      end

      def pricing_skus(product)
        existing = Pricing::Sku.in(id: product.skus).to_a
        missing_skus = product.skus - existing.map(&:id)
        existing + missing_skus.map { |sku| Pricing::Sku.new(id: sku) }
      end

      def apply_inventory!(product)
        return unless inventory.present?

        collection = Inventory::Collection.new(product.skus)

        collection.records.each do |record|
          record.update_attributes!(inventory)
        end
      end
    end
  end
end
