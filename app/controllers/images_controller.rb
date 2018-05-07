class ImagesController < ApplicationController
  def index
    @images = Image.where(user: current_user)
  end

  def new
    @upload_form = UploadForm.new(images: []).as(current_user)
  end

  def create
    #TODO add exception when no image
    @upload_form = UploadForm.new(images: params[:files]).as(current_user)

    if @upload_form.save
      redirect_to images_path, notice: "The image has been uploaded."
    else
      render :new
    end
  end
end

