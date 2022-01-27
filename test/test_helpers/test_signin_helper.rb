module TestSigninHelper
  def signin_as(user)
    post signin_url(email: user.email, password: user.password)
  end
end