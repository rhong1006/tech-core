class User < ApplicationRecord

  # resolved conflict by adding dependent: :destroy
  has_many :organizations, dependent: :destroy

  # geocoded_by :address
  # after_validation :geocode

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
#   VALID_PASSWORD_REGEX = /(      # Start of group
#         (?:                        # Start of nonmatching group, 4 possible solutions
#           (?=.*[a-z])              # Must contain one lowercase character
#           (?=.*[A-Z])              # Must contain one uppercase character
#           (?=.*\W)                 # Must contain one non-word character or symbol
#         |                          # or...
#           (?=.*\d)                 # Must contain one digit from 0-9
#           (?=.*[A-Z])              # Must contain one uppercase character
#           (?=.*\W)                 # Must contain one non-word character or symbol
#         |                          # or...
#           (?=.*\d)                 # Must contain one digit from 0-9
#           (?=.*[a-z])              # Must contain one lowercase character
#           (?=.*\W)                 # Must contain one non-word character or symbol
#         |                          # or...
#           (?=.*\d)                 # Must contain one digit from 0-9
#           (?=.*[a-z])              # Must contain one lowercase character
#           (?=.*[A-Z])              # Must contain one uppercase character
#         )                          # End of nonmatching group with possible solutions
#         .*                         # Match anything with previous condition checking
#       )/x                          # End of group


  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  validates :password, length: { minimum: 6 }

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end


end
