class RoomsController < ApplicationController

  def index
    @public_rooms = Room.public_room
    @private_rooms = current_user.rooms.private_room
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params.merge(created_by: current_user))
    if @room.save
      room_user_ids = room_params[:user_ids].reject(&:blank?)
      room_user_ids.unshift(current_user.id.to_s)
      room_user_ids.uniq.each do |user_id|
        RoomUser.create(user_id: user_id, room: @room) if User.exists?(user_id)
      end
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :room_type, user_ids: [])
  end

end
