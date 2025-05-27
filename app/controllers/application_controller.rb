# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def set_previous_url
    session[:previous_url] = request.fullpath
  end

  def reset_previous_url
    session[:previous_url] = nil
  end
end
