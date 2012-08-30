class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @period = Period.find_by_account_id_and_state(current_user.account_id, 'open').end_date
    @period_default = Period.find(:all, :conditions => { :account_id => current_user.account_id, :state => "open", :name => "**Default Period**" }).count
    @review_id = Review.find_by_user_id_and_state(current_user, 'open').id
    @goals = Goal.find_all_by_user_id_and_review_id(current_user, @review_id)
  end
end