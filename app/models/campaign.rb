class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :contributions

  attr_accessible :title, :amount
  attr_protected :user
  
  validates :user, :presence => true
  validates :title, :presence => true
  validates :amount, :presence => true
  
  
  def total_contributions
  	sum = 0
  	self.contributions.each do |cntrb| 
  		sum = sum.+(cntrb.amount)
  	end
  	return sum
  end
  
  def paid_contributions
  	sum = 0
  	self.contributions.each do |cntrb|
  		sum = sum.+(cntrb.amount) if cntrb.is_paid
  	end
  	return sum
  end
  
end
