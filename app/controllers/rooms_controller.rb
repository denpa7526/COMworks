class RoomsController < ApplicationController

  def new
    @room = Room.new
    @users = User.where.not(id: current_user.id)
  end

  def create
  end

end
