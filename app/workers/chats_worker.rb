class ChatsWorker

    include Sneakers::Worker
        
    from_queue "chats", env: nil

    def work(chat_data)
        ActiveRecord::Base.connection_pool.with_connection do
            chat_data = JSON.parse(chat_data)
            chat = Chat.new
            chat.number = chat_data['number']
            chat.application = Application.find(chat_data['application_id'])
            chat.save!
            puts "Chat saved successfully " + chat.inspect
        end
        ack!
    end
end