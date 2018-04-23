class ImagesController < ApplicationController
  def index
    @images = Image.where(user: current_user)
  end
end