class Event < ApplicationRecord
  belongs_to :organization

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true


  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_before_start_date

  def start_date_cannot_be_in_the_past
    if start_time.present? && start_time < Date.today
      errors.add(:start_time, "can't be in the past")
    end
  end

  def end_date_cannot_be_before_start_date
    if end_time.present? && end_time < start_time
      errors.add(:end_time, "can't be before start time")
    end
  end

end
