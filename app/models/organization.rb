class Organization < ApplicationRecord
  belongs_to :user #User who creates the organization || admin
  has_many :tags, through: :taggings
  has_many :taggings, dependent: :destroy

  has_many :events, dependent: :destroy

  mount_uploader :logo, LogoUploader

  # NOTE remove validations from seed file because the seed generates random text, not images
  # validates :logo, presence: true

  # NOTE geocoded is overloaded and gives an API error
  # geocoded_by :address
  # after_validation :geocode


  # geocoded_by :address
  # after_validation :geocode

  scope :search_by_name, -> (name) {
    where("name ILIKE  '%#{name}%'")
  }

  scope :search_by_tag, -> (tag_array) {
    joins(:taggings).where("taggings.tag_id IN (:tags)", tags: tag_array)
  }

  scope :search_by_tech_size, -> (team_size) {
    where("tech_team_size <= #{team_size}+5 AND tech_team_size >= #{team_size}-5")
  }

end
