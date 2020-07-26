class Ticket < ActiveRecord::Base
    belongs_to :user
    has_many :previews
    has_many :clients, through: :previews
end
