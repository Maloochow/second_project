class Gallery < ActiveRecord::Base
    has_many :users, :dependent => :nullify
    has_many :client_gallery_statuses
    has_many :tickets, through: :users
    has_many :user_invites, through: :users
    has_many :clients, through: :client_gallery_statuses

    validates :name, presence: true, uniqueness: true
end
