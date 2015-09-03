class Review < ActiveRecord::Base
  belongs_to :restaurant
  validates :rating, inclusion: (1..5)
end
