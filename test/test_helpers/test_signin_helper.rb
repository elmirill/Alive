module TestSigninHelper
  def signin(user)
    post signin_url(email: user.email, password: user.password)
  end

  def signup(user)
    post signup_url, params: { user: { email: user.email,
                                       first_name: user.first_name,
                                       last_name: user.last_name,
                                       password: user.password } }
  end

  def signout
    delete signout_url
  end
end