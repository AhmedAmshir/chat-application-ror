class Chat < ApplicationRecord
  
  belongs_to :application
  has_many :messages, dependent: :destroy

  # trigger.after(:insert) do
  #   "UPDATE applications SET chats_count = chats_count + 1 WHERE applications.id = NEW.application_id;"
  # end

  # trigger.after(:delete) do
  #   "UPDATE applications SET chats_count = chats_count - 1 WHERE applications.id = OLD.application_id;"
  # end

end
