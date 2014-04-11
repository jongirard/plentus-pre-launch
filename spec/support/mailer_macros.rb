module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end
  
  def reset_email
    ActionMailer::Base.deliveries = []
  end
  
  def extract_token_from_email(token_name)
    mail_body = last_email.body.to_s
    mail_body[/#{token_name.to_s}_token=([^"]+)/, 1]
  end
  
end