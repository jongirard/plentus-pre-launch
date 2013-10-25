class User < ActiveRecord::Base
  validates_presence_of :fullname
  validates_presence_of :email
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
end

public
def subscribe
  
  user = User.new(fullname: fullname, email: email )
  user.save
  
end
