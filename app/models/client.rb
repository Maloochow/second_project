class Client < ActiveRecord::Base
    has_many :previews
    has_many :tickets, through: :previews
    has_many :client_gallery_statuses
    has_many :galleries, through: :client_gallery_statuses
    has_many :users, through: :tickets

    validates :app_id, presence: true, uniqueness: true
end
