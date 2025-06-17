# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(user_id: current_user.id, content: params[:message][:content])
    @message.save!
    redirect_to request.referer, notice: 'メッセージが送信されました'
  end
end
