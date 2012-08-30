class User < ActiveRecord::Base
  belongs_to :account, :inverse_of => :users
  has_many :reviews
  has_many :periods, :through => :reviews
  has_many :goals
  has_many :progresses
  has_many :subordinates, :class_name => "User", :foreign_key => "supervisor_id"
  belongs_to :supervisor, :class_name => "User"

  accepts_nested_attributes_for :account

  validate :account_has_quota
  before_create :decrement_quota_count
  after_create :initialize_period_review

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :admin, :first_name, :last_name, :account_id, :type, :supervisor_id, :account_attributes

  private

  def account_has_quota
    unless account.user_limit > 0
      errors[:base] << 'You have reached your limit of user.'
    end
  end

  def decrement_quota_count
    account.decrement! :user_limit
  end

  def initialize_period_review
    period = Period.find_by_account_id_and_state(self.account_id, 'open')

    if period.nil?
      period = Period.create(:name => "**Default Period**",
                           :start_date => Date.today,
                           :end_date => Date.today,
                           :account_id => self.account_id)
    else
      review = Review.create(:account_id => self.account_id,
                             :period_id => period.id,
                             :user_id => id)
    end
  end
end
