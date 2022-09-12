require 'elasticsearch/model'

class Message < ApplicationRecord
  
  belongs_to :chat

  validates_presence_of :body

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # index_name Rails.application.class.parent_name.underscore

  # settings index: { number_of_shards: 1 } do
  #   mappings do
  #     indexes :number, type: :long
  #     indexes :chat_id, type: :long
  #     indexes :body, type: :text, analyzer: 'english'
  #   end
  # end

  # def as_indexed_json(options = nil)
  #   self.as_json(
  #     only: [:number, :chat_id, :body]
  #   )
  # end

  # trigger.after(:insert) do
  #   "UPDATE chats SET messages_count = messages_count + 1 WHERE chats.id = NEW.chat_id;"
  # end

  # trigger.after(:delete) do
  #   "UPDATE chats SET messages_count = messages_count - 1 WHERE chats.id = OLD.chat_id;"
  # end

  def self.search(q, chat)
    __elasticsearch__.search({
      "query": {
        "bool": {
          "must": {
            "wildcard": { "body": "*"+q.downcase+"*" }
          },
          "filter": {
            "term": { "chat_id": chat.id }
          }
        }
      }
    })
  end

end
