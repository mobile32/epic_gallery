class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.where(user: current_user)
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to galleries_path, notice: "The gallery has been created."
    else
      render :new
    end
  end

  def gallery_params
    params.require(:gallery).permit(:cover_image, :title, :description).merge(user: current_user)
  end
end