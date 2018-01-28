class Organization < ApplicationRecord
  belongs_to :user #User who creates the organization || admin
  has_many :tags, through: :taggings
  has_many :taggings, dependent: :destroy
  has_many :events


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
