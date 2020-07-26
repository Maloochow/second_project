class ClientGalleryStatus < ActiveRecord::Base
    belongs_to :client
    belongs_to :gallery
end