module Workarea
  module Admin
    module IconsHelper
      def upcoming_changesets_icon_for(model)
        return unless model.timeline.upcoming_changesets.any?

        link_to(
          inline_svg('workarea/admin/icons/timeline.svg',
            title: t('workarea.admin.timeline.card.title'),
            class: 'svg-icon svg-icon--small svg-icon--link-color'
          ),
          timeline_path(model.timeline.to_global_id),
          title: t('workarea.admin.timeline.card.title'),
          class: 'link link--no-underline'
        )
      end

      def comments_icon_for(model)
        return unless model.has_comments?
        svg =
          if model.new_comments_for?(current_user)
            inline_svg(
              'workarea/admin/icons/comments.svg',
              title: t('workarea.admin.comments.icon.unviewed'),
              class: 'svg-icon svg-icon--small svg-icon--link-color'
            )
          else
            inline_svg(
              'workarea/admin/icons/comments_viewed.svg',
              title: t('workarea.admin.comments.icon.viewed'),
              class: 'svg-icon svg-icon--small svg-icon--link-color'
            )
          end

        link_to(
          svg,
          commentable_comments_path(model.to_global_id),
          title: t('workarea.admin.comments.card.title'),
          class: 'link link--no-underline'
        )
      end

      def admin_icon_for(model)
        return unless model.admin?

        link_to(
          inline_svg('workarea/admin/icons/permissions.svg',
            title: t('workarea.admin.users.cards.permissions.title'),
            class: 'svg-icon svg-icon--small svg-icon--link-color'
          ),
          permissions_user_path(model),
          title: t('workarea.admin.users.cards.permissions.title'),
          class: 'link link--no-underline'
        )
      end

      def top_icon_for(model)
        return unless model.insights.top?

        link_to(
          inline_svg('workarea/admin/icons/star.svg',
            title: t('workarea.admin.insights.icons.top_selling'),
            class: 'svg-icon svg-icon--small svg-icon--link-color'
          ),
          insights_path_for(model),
          title: t('workarea.admin.insights.icons.top_selling'),
          class: 'link link--no-underline'
        )
      end

      def trending_icon_for(model)
        return unless model.insights.trending?

        link_to(
          inline_svg('workarea/admin/icons/fire.svg',
            title: t('workarea.admin.insights.icons.trending'),
            class: 'svg-icon svg-icon--small svg-icon--link-color'
          ),
          insights_path_for(model),
          title: t('workarea.admin.insights.icons.trending'),
          class: 'link link--no-underline'
        )
      end

      def favicon_icon_for(model)
        return unless model.favicon?

        inline_svg('workarea/admin/icons/favicon.svg',
          title: t('workarea.admin.content_assets.index.favicon'),
          class: 'svg-icon svg-icon--small svg-icon--gray'
        )
      end
    end
  end
end
