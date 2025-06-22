# frozen_string_literal: true

class RoomsController < ApplicationController
  # ログインユーザーとDMする相手ユーザーのroomが存在するか調べる。なければ作成する。
  def create
    @user = User.find_by(id: params[:user_id])
    my_room_ids = current_user.entries.pluck(:room_id)
    existing_room = @user.entries.find_by(room_id: my_room_ids)

    if existing_room.nil?
      ApplicationRecord.transaction do
        @room = Room.create!
        @room.entries.create!(user_id: current_user.id)
        @room.entries.create!(user_id: @user.id)
      end
    end
    redirect_to rooms_path
  end

  def index
    my_room_ids = current_user.entries.pluck(:room_id)
    @another_entries = Entry.where(room_id: my_room_ids)
                            .where.not(user_id: current_user.id)
                            .includes(user: { icon_image_attachment: :blob })

    return unless params[:tab] == 'room'

    @room = Room.find(params[:room_id])
    @messages = @room.messages
    @message = Message.new
    @another_entry = @room.entries.where.not(user_id: current_user.id).first
  end
end
