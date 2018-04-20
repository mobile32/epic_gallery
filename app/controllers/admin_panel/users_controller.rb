module AdminPanel
  class UsersController < ApplicationController
    def index
      authorize User
      @users = User.all
    end
  end
end
