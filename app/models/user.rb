class User < ActiveRecord::Base
    has_secure_password

    belongs_to :gallery
    has_many :tickets
    has_many :user_invites
    has_many :clients, through: :tickets
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end
