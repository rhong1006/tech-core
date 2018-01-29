class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :organizations, through: :taggings
end
