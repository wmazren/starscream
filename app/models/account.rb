class Account < ActiveRecord::Base
  has_many :users, :inverse_of => :account, :dependent => :destroy
  has_many :periods
  has_many :reviews

  attr_accessible :name, :phone, :fax, :address1, :address2, :city, :postcode, :state, :country, :user_limit, :renewal_date, :expiry_date
end
