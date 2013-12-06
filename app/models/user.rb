class User < ActiveRecord::Base
  validates_presence_of :fullname, :message => "Required Field"
  validates_presence_of :email, :message => "Required Field"
  validates_format_of :email, :message => "Email Address is invalid", :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_uniqueness_of :email, :message => "Email Address already signed up"
  before_save { self.email = email.downcase }
  
  def signup

    user = User.new(fullname: fullname, email: email )
    user.save

  end
  
  #after_save { self.delay.subscribe }
  
  def subscribe
     mailchimp = Gibbon::API.new
      result = mailchimp.lists.subscribe({
        :id => ENV['MAILCHIMP_LIST_ID'],
        :email => {:email => self.email},
        :double_optin => false,
        :update_existing => true,
        :send_welcome => false
      })
      Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
  end
end





