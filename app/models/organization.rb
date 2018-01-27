class Organization < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :taggings
  has_many :taggings, dependent: :destroy
  has_many :events
end
