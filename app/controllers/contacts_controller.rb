class ContactsController < ApplicationController
  respond_to :html, :js

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      respond_to do |format|
        format.html { redirect_to contacts_path }
        format.js { flash.now[:notice] = "Saved" }
      end
    else
      redirect_to contacts_path
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
