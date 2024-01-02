class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_info_rest,
  against: [ :name, :description,:address ],
  using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
