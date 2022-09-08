class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  has_one_attached :photo

  after_commit :add_default_picture, on: %i[create]

  include PgSearch::Model
  pg_search_scope :search_by_email,
    against: [ :email ],
    using: {
      tsearch: { prefix: true }
    }

  def add_default_picture
    unless photo.attached?
      photo.attach(
        io: File.open(File.join(Rails.root, 'app/assets/images/blank-profile-picture.png')),
        filename: 'blank-profile-picture.png',
        content_type: 'image/png'
    )
    end
  end
end
