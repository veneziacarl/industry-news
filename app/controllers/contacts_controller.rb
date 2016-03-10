class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new(contact_params)

    if contact.save
      flash[:notice] = "Your email #{ contact_params[:email] } has been successfully added to the list!"
      redirect_to root_path
    else
      error = contact.errors.messages[:email].first
      if error == 'has already been taken'
        flash[:error] = 'Your email is already on our mailing list!'
      elsif error == 'invalid email format'
        flash[:error] = 'You have entered an invalid email address!'
      end
      redirect_to root_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email)
  end
end
