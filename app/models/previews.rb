class Preview < ActiveRecord::Base
    belongs_to :client
    belongs_to :ticket
end