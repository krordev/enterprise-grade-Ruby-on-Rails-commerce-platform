module Workarea
  class Alerts
    def products_missing_prices
      @products_missing_prices ||= Search::AdminProducts
        .new(
          status: ['active'],
          issues: [I18n.t('workarea.alerts.issues.sku_missing_price')]
        )
        .total
    end

    def empty_categories
      @empty_categories ||= Search::AdminCategories
        .new(issues: [I18n.t('workarea.alerts.issues.no_displayable_products')])
        .total
    end

    def products_missing_images
      @products_missing_images ||= Search::AdminProducts
        .new(
          status: ['active'],
          issues: [I18n.t('workarea.alerts.issues.no_images')]
        )
        .total
    end

    def products_missing_descriptions
      @products_missing_descriptions ||= Search::AdminProducts
        .new(
          status: ['active'],
          issues: [I18n.t('workarea.alerts.issues.no_description')]
        )
        .total
    end

    def products_missing_variants
      @products_missing_variants ||= Search::AdminProducts
        .new(issues: [I18n.t('workarea.alerts.issues.no_variants')])
        .total
    end

    def products_missing_categories
      @products_missing_categories ||= Search::AdminProducts
        .new(
          status: ['active'],
          issues: [I18n.t('workarea.alerts.issues.no_categories')]
        )
        .total
    end

    def products_low_inventory
      @products_low_inventory ||= Search::AdminProducts
        .new(issues: [I18n.t('workarea.alerts.issues.low_inventory')])
        .total
    end

    def products_variants_missing_details
      @products_variants_missing_details ||= Search::AdminProducts
        .new(
          issues: [I18n.t('workarea.alerts.issues.variants_missing_details')]
        )
        .total
    end

    def products_inconsistent_variant_details
      @products_inconsistent_variant_details ||= Search::AdminProducts
        .new(
          issues: [
            I18n.t('workarea.alerts.issues.inconsistent_variant_details')
          ]
        )
        .total
    end

    def empty_upcoming_releases
      @empty_upcoming_releases ||= Release
                                    .scheduled
                                    .asc(:publish_at)
                                    .reject(&:has_changes?)
    end
  end
end
