module SessionsHelper
  #Create a session for a user. A session has a token (that is being saved in the db in an encrypted format), a cookie
  # and is assinged to a specific user.
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  # verify if a user has an active session
  def signed_in?
    !current_user.nil?
  end

  # sign the user out, remove the session and delete the cookie.
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  #a get method to get the user that is currently logged in
  def current_user=(user)
    @current_user = user
  end

  #compares the cookie to the encrypted session in the db to authanticate the user.
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

end
