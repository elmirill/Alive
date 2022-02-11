module TestSigninHelper
  def sign_up(user)
    post signup_url, params: { user: { email: user.email,
                                       first_name: user.first_name,
                                       last_name: user.last_name,
                                       password: user.password } }
  end

  def sign_out_user
    delete signout_url
  end
end