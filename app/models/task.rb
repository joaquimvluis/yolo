class Task < ApplicationRecord
  belongs_to :experience

  has_many :users
end
