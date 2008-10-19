class UserMailer < ActionMailer::Base
  def message(user, message)
    @recipients  = user.email
    @from        = "SoDA"
    @subject     = "[SoDA Message] "
    @sent_on     = Time.now
    @body[:message] = message
  end

end
