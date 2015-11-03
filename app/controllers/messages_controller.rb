class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @contacts = Contact.all
  end

  def create
    # @contacts = Contact.all
    params_saved = params
    from = params[:from]
    body = params[:body]
    to = []


    if params_saved[:to].present?
      to = to.push(params_saved[:to]).first
      params = { to: to, from: from, body: body}
      @message = Message.new(params)
      if @message.save
        respond_to do |format|
          format.html { redirect_to messages_path }
          format.js { flash.now[:notice] = "Message Sent!!" }
        end
      else
        redirect_to messages_path
      end
    elsif params_saved[:contact_ids].any?
      params_saved[:contact_ids].each do |contact|
        found_contact = Contact.find(contact)
        to.push(found_contact.phonenumber)
      end
    end

    if to.class == Array && to.length > 1
      to.each do |t|
        Message.create({to: t, body: body, from: from})
      end
      respond_to do |format|
        format.html { redirect_to messages_path }
        format.js { render :messages_sent }
      end

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
