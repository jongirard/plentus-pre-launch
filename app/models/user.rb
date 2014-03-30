class User < ActiveRecord::Base
  belongs_to :country
  belongs_to :state
  has_one :tax, :dependent => :destroy
  has_one :deduction, :dependent => :destroy
  has_many :debts, :dependent => :destroy
  has_many :expenses, :dependent => :destroy
  # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :trackable, :validatable, :confirmable, :async
               
  validates_presence_of :fullname
  validates_presence_of :email
  validates_presence_of :password, { :on => :create }
  validates_presence_of :country_id
  validates_format_of :fullname, :with => /\A^[a-z ,.'-]+$\z/i
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_uniqueness_of :email
  before_save { self.email = email.downcase }
  
  def signup

    user = User.new(fullname: fullname, email: email, password: password, country_id: country_id, state_id: state_id)
    user.save

  end
  
  def flexible_income
    income
  end

  def flexible_income=(income)
    self.income = income.tr('$ ,', '') unless income.blank?
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





