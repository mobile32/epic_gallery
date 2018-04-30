class ImagesController < ApplicationController
  def index
    # @images = Image.where(user: current_user).images.flatten
  end

  def new
    @upload_form = Upload.new(images: [], user: current_user)
  end

  def create
    @upload_form = Upload.new(images: images, user: current_user)

    if @upload_form.save
      redirect_to uploads_path, notice: "The image has been uploaded."
    else
      render :new
    end
  end

  private

  #TODO add exception when no image
  def images
    params.require(:upload).require(:files)
  end
end

