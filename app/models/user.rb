class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation
  
  has_many :tasks
end
