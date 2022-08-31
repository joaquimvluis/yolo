class Task < ApplicationRecord
  belongs_to :experience

  has_many :user_tasks
  has_many :users, through: :user_tasks

  validates :deadline, presence: true
end
