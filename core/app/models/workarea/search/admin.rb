module Workarea
  module Search
    class Admin
      include Elasticsearch::Document

      def self.jump_to(params, size = Workarea.config.default_admin_jump_to_result_count)
        query = {
          query: {
            match_phrase_prefix: {
              jump_to_search_text: {
                query: params[:q],
                max_expansions: 10
              }
            }
          },
          size: size,
          sort: [{ jump_to_position: :asc }]
        }

        search(query)['hits']['hits'].map do |result|
          {
            label: result['_source']['jump_to_text'],
            type: result['_source']['facets']['type'],
            model_class: result['_source']['model_class'],
            route_helper: result['_source']['jump_to_route_helper'],
            to_param: result['_source']['jump_to_param']
          }
        end
      end

      def self.for(model)
        subclass = model.model_name.singular_route_key.camelize
        "Workarea::Search::Admin::#{subclass}".constantize.new(model)
      rescue NameError
        nil
      end

      # Allows subclass instances to specify whether they should be included in
      # the Admin index. For example, allow system Content to be included,
      # but not Content that belongs to a model.
      #
      # @return [Boolean]
      #
      def should_be_indexed?
        true
      end

      def id
        "#{type}-#{model.id}"
      end

      def name
        model.name
      end

      def type
        model.class.name.demodulize.underscore
      end

      def status
        nil
      end

      def search_text
        raise(NotImplementedError, "#{self.class} must implement #search_text")
      end

      def keywords
        [model.id, *model.try(:tags)]
      end

      def sanitized_keywords
        keywords.reject(&:blank?).map(&:to_s).map(&:downcase).map(&:strip)
      end

      def facets
        base = { status: status, type: type }
        base[:tags] = model.tags if model.respond_to?(:tags)
        base
      end

      def jump_to_text
        name
      end

      def jump_to_search_text
        search_text
      end

      def jump_to_position
        999
      end

      def jump_to_route_helper
        "#{model.model_name.singular_route_key}_path"
      end

      def jump_to_param
        model.to_param
      end

      def created_at
        model.created_at
      end

      def updated_at
        model.updated_at
      end

      def releasable?
        model.is_a?(Workarea::Releasable)
      end

      def as_document
        {
          id: id,
          name: name,
          facets: facets,
          created_at: created_at,
          updated_at: updated_at,
          keywords: sanitized_keywords,
          search_text: search_text,
          jump_to_text: jump_to_text,
          jump_to_search_text: jump_to_search_text,
          jump_to_position: jump_to_position,
          jump_to_route_helper: jump_to_route_helper,
          jump_to_param: jump_to_param,
          releasable: releasable?
        }
      end
    end
  end
end
