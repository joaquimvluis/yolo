class Task < ApplicationRecord
  belongs_to :experience

  has_many :user_tasks
  has_many :users, through: :user_tasks

  validates :title, presence: true, length: { maximum: 50 }
end
