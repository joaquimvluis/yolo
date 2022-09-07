class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_email,
    against: [ :email ],
    using: {
      tsearch: { prefix: true }
    }
end
