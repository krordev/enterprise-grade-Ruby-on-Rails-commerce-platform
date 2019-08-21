module Workarea
  module Admin
    class CreateReleaseUndosController < Admin::ApplicationController
      required_permissions :releases

      before_action :find_release
      before_action :find_undo_release

      def new
      end

      def create
        @undo_release.attributes = params[:release]

        if @undo_release.save
          @release.changesets.each do |changeset|
            changeset.build_undo(release: @undo_release.model).save!
          end

          flash[:success] = t('workarea.admin.create_release_undos.flash_messages.saved')
          redirect_to review_release_undo_path(@release)
        else
          render :new, status: :unprocessable_entity
        end
      end

      def review
      end

      private

      def find_release
        model = Release.find(params[:release_id])
        @release = ReleaseViewModel.new(model, view_model_options)
      end

      def find_undo_release
        model = @release.model.undo || @release.build_undo(params[:release])
        @undo_release = ReleaseViewModel.new(model, view_model_options)
      end
    end
  end
end
