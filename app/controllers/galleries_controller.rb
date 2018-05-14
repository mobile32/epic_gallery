class GalleriesController < ApplicationController
  def index
    @galleries = current_user.galleries
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to galleries_path, notice: t('galleries.created')
    else
      render :new
    end
  end

  def gallery_params
    params.require(:gallery).permit(:cover_image, :title, :description).merge(user: current_user)
  end
end