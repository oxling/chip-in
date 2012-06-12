require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  attr_protected :id, :salt, :hashed_password
  
  has_many :campaigns
  has_many :contributions
  
  #Regex borrowed from http://stackoverflow.com/questions/201323/
  validates :email, :uniqueness => true, :presence => true, :format => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/
  validates :hashed_password, :presence => true
  validates :salt, :presence => true
  validates :password, :presence => true, :length => 1..100, :confirmation => true
  validates :password_confirmation, :presence => true, :length => 1..100
  
  def self.generate_salt(len)
  	chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  	newpass = ""
  	1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
  	return newpass
  end
  
  def self.encrypt(pass, salt)
  	Digest::SHA1.hexdigest(pass+salt)
  end
  
  def password=(pass)
    @password=pass
  	self.salt = User.generate_salt(10) if !self.salt?
  	self.hashed_password = User.encrypt(pass, self.salt)
  end
  
  def password
  	return @password
  end
  
  def name
  	return @name unless @name == nil
  	return "Anonymous" + self.id.to_s
  end
    
  def self.authenticate(email, pass)
  	user=User.find(:first, :conditions=>["email = ?", email])
  	
  	if user == nil
  	 return nil
  	end
  	
  	if User.encrypt(pass, user.salt) == user.hashed_password
  		return user.id
  	else
  		return nil
  	end

  end
  
  def contributed_campaigns
  	campaigns = Campaign.joins(:contributions).where(:contributions => {:user_id => self.id }).uniq
  end
    
end
