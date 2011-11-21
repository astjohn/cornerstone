module MailerMacros

  def last_email
    ActionMailer::Base.deliveries.last
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end

  def emails
    ActionMailer::Base.deliveries
  end

end
