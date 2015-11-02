class ContactsController < ApplicationController
  respond_to :html, :js

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = "Your contact was saved!"
      redirect_to contacts_path
    else
      render 'new'
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def edit
    @contact = Contact.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      respond_to do |format|
        format.html { redirect_to contacts_path }
        format.js { flash.now[:notice] = "Changes Saved" }
      end
    else
      redirect_to contact_path(@contact)
    end
  end

private

  def contact_params
    params.require(:contact).permit(:name, :phonenumber)
  end
end
