class ContactController < ApplicationController
  def contact
  end

  def create
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
  end
end
