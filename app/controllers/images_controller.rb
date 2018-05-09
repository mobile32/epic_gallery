class ImagesController < ApplicationController
  def index
    @images = Image.where(user: current_user)
  end

  def new
    @upload_form = UploadForm.new(images: []).as(current_user)
    @galleries = current_user.galleries
  end

  def create
    #TODO add exception when no image
    @upload_form = UploadForm.new(images: upload_params[:files], galleries_ids: upload_params[:galleries_ids]).as(current_user)

    if @upload_form.save
      redirect_to images_path, notice: "The image has been uploaded."
    else
      @galleries = current_user.galleries
      render :new
    end
  end

  private

  def upload_params
    params.require(:upload)
  end
end

