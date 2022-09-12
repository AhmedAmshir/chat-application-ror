class Application < ApplicationRecord
    
    has_many :chats, foreign_key: 'application_id', primary_key: 'id', dependent: :destroy

    validates_presence_of :name

    def create_token
        token = Digest::MD5.hexdigest "#{SecureRandom.hex(10)}-#{DateTime.now.to_s}"
        token
    end

end
