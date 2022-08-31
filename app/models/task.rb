class Task < ApplicationRecord
  belongs_to :experience

  has_many :users

  validates :deadline, presence: true
end
