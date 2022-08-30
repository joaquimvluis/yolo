class Experience < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
                  against: [ :title, :description ],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }

  has_many :experience_categories
  has_one_attached :photo
end
