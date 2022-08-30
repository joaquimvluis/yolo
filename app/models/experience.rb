class Experience < ApplicationRecord
  has_many :experience_categories
  has_one_attached :photo
end
