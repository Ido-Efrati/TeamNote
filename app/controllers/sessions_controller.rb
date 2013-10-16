class SessionsController < ApplicationController
	
  #New checks if a user already signed in (i.e there is a session), if there is a session the user will be redirected to his/her notes
  # else the user will go to the log in page
  def new
    if signed_in?
      redirect_to notes_path
    end
  end

  #Create - tries to create a session by authentiating the email and the password. If the authentication was sucessful 
  # a session will be created for that user, otherwise the user will be prompted with an error message.
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to notes_path
    else
      redirect_to signin_path, :flash => { :error => "Invalid email/password combination" }

    end
  end

  # destroy the session and redirect the user to the login page
  def destroy
    sign_out
    redirect_to root_url
  end

end
