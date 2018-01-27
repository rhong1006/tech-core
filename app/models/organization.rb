class Organization < ApplicationRecord
  belongs_to :user #User who creates the organization || admin
  has_many :tags, through: :taggings
  has_many :taggings, dependent: :destroy
  has_many :events


  scope :search_by_name, -> (name) {
    where("name ILIKE  '%#{name}%'")
  }

  scope :search_by_tag, -> (tag_array) {
    # puts "===========tag_array length"
    # puts tag_array
    # tag_array.each do |tag_id|
    #   # Tagging.where tag_id:tag_id do |t|
    #   #   Organization.where t.organization
    #   # end
    #   # where("name ILIKE  '%#{tag_name}%'")
    #   Tagging.joins(
    #     "INNER JOIN tag
    #     WHERE taggings.id = tag_id
    #     ON taggings.tag_id = tags.id"
    #   )
    #
    # end
# => Organization.joins(:some_table)
    joins(:taggings).where("taggings.tag_id IN (:tags)", tags: tag_array)
  }

end
