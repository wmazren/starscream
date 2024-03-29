class Review < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :period
  has_many :goals

  after_create :change_review_state
  after_update :close_goals

  state_machine :initial => :unregistered do
    event :opener do
      transition :unregistered => :open
    end

    event :closer do
      transition :open => :closed
    end
  end

  attr_accessible :subordinate_comments, :supervisor_comments, :rating, :final_comments, :state,
                  :user_id, :period_id, :account_id

  private

  def change_review_state
    self.opener
  end

  def close_goals
    r = self
    if r.state == "closed"
      goals = Goal.find(:all, :conditions => { :review_id => self })

      goals.each do |goal|
        goal.closer
      end
    end
  end
end
