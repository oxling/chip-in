class Contribution < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  
  attr_protected :amount, :user, :is_paid
  
  validates :user_id, :presence => true
  validates :amount, :presence => true,
  									 :numericality => true

end
