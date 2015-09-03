class Restaurant < ActiveRecord::Base
	
	belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true
  

end
