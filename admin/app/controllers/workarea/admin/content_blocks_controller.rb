module Workarea
  class Admin::ContentBlocksController < Admin::ApplicationController
    required_permissions :store

    before_action :find_content, except: :index
    before_action :find_block, except: [:index, :move]
    before_action :check_publishing_authorization

    def index
      @return = params[:return_to].to_h

      @system_block_types = Workarea.config.content_block_types
      @content_presets = Content::Preset.all.to_a
    end

    def create
      if @block.save
        flash[:success] = t('workarea.admin.content_blocks.flash_messages.added')
      else
        flash[:error] = @block.errors.to_a.to_sentence
      end

      redirect_to return_to || edit_content_path(
        @content,
        release_id: @block.activate_with
      )
    end

    def update
      @block.attributes = params[:block]

      if @block.save
        flash[:success] = t('workarea.admin.content_blocks.flash_messages.saved')
      else
        flash[:error] = @block.errors.to_a.to_sentence
      end

      redirect_to return_to || edit_content_path(@content)
    end

    def move
      position_data = params.fetch(:block, [])

      position_data.each do |block_id, position|
        block = @content.blocks.find(block_id)
        block.position = position
        block.save!
      end

      flash[:success] = t('workarea.admin.content_blocks.flash_messages.moved')

      head :ok
    end

    def destroy
      if current_release.present?
        @block.active = false
        @block.save
      else
        @block.destroy
      end

      flash[:success] = t('workarea.admin.content_blocks.flash_messages.removed')
      redirect_to return_to || edit_content_path(@content)
    end

    def allow_publishing?
      super || (
        defined?(@content) &&
        (
          !@content.active? ||
          (@content.contentable.present? && !@content.contentable.active?)
        )
      )
    end

    private

    def find_content
      model = Content.find(params[:content_id])
      @content = Workarea::Admin::ContentViewModel.new(
        model,
        view_model_options
      )
    end

    def find_block
      @block = if params[:id].present?
                 @content.blocks.find(params[:id])
               else
                 @content.blocks.build(
                   params[:block].merge(area: params[:area_id])
                 )
               end
    end

    def block_params
      return { area: params[:area_id] } if params[:block].blank?

      params[:block]
        .merge(area: params[:area_id])
        .tap { |p| p[:data] = params[:block][:data] || {} }
    end
  end
end
