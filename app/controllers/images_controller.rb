class ImagesController < ApplicationController
  def index
    @filters = ImagesFiltersForm.new(tags: tags)
    @images  = current_user.images.with_selected_tags(tags: tags)
  end

  def new
    @upload_form = UploadForm.new(images: []).as(current_user)
    @galleries   = current_user.galleries
  end

  def create
    @upload_form = UploadForm.new(upload_params).as(current_user)

    if @upload_form.save
      redirect_to images_path, notice: "The image has been uploaded."
    else
      @galleries    = current_user.galleries
      flash[:error] = t('images.errors.upload_failed')
      render :new
    end
  end

  private

  def upload_params
    params.require(:upload)
  end

  def tags
    params.dig(:images_filters, :tags)
  end
end

