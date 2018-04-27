class UploadsController < ApplicationController
  def index
    @uploads = Upload.where(user: current_user)
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      redirect_to uploads_path, notice: "The image has been uploaded."
    else
      render :new
    end
  end

  private

  def upload_params
    params.require(:upload).permit({:images => []}).merge(user: current_user)
  end
end

