class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.where(user: current_user)
  end
end