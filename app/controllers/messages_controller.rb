class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @contacts = Contact.all
  end

  def create
    from = params[:from]
    body = params[:body]
    if params[:to].present? && params[:to_collection].present?
      flash[:notice] = "You can only choose one number"
      render "new"
    elsif params[:to].present?
      to = params[:to]
    else params[:to_collection].present?
      to = params[:to_collection]
    end
    params = { to: to, from: from, body: body}
    @message = Message.new(params)
    @contacts = Contact.all

    if @message.save
      flash[:notice] = "Your message was sent!"
      redirect_to messages_path
    else
      render 'new'
    end
  end

  def show
    @message = Message.find(params[:id])
  end

# private
#
#   def message_params
#     params.require(:message).permit(:to, :from, :body)
#   end
end
