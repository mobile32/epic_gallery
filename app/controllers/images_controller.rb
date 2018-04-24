class ImagesController < ApplicationController
  def index
    @images = Image.where(user: current_user)
  end

  def show
    @image = Image.where(user: current_user).find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to images_path, notice: "The image has been uploaded."
    else
      render :new
    end
  end

  private

  def image_params
    params.require(:image).permit(:image_file, :description, :localization).merge(user: current_user)
  end
end

