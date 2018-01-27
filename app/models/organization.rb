class Organization < ApplicationRecord
  belongs_to :user #User who creates the organization || admin
  has_many :tags, through: :taggings
  has_many :taggings, dependent: :destroy
  has_many :events


  scope :search, -> (name) {
    where("name ILIKE  '%#{name}%'")
  }

end
