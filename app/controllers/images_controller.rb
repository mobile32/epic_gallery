class ImagesController < ApplicationController
  def index
    @images = current_user.images
  end

  def new
    @upload_form = UploadForm.new(images: []).as(current_user)
    @galleries = current_user.galleries
  end

  def create
    @upload_form = UploadForm.new(upload_params).as(current_user)

    if @upload_form.save
      redirect_to images_path, notice: "The image has been uploaded."
    else
      @galleries = current_user.galleries
      flash[:error] = t('images.errors.upload_failed')
      render :new
    end
  end

  private

  def upload_params
    params.require(:upload)
  end
end

