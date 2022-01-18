class UserMailer < ApplicationMailer

  default from: 'suulaemon@gmail.com'
  def forgot_password(user)
    @user = user
    @greeting = "Hi"
    
    mail to: user.email, :subject => 'Reset password instructions'
  end
end
