class MessagesWorker
    
    include Sneakers::Worker
        
    from_queue "messages", env: nil

    def work(msg_data)
        ActiveRecord::Base.connection_pool.with_connection do
            msg_data = JSON.parse(msg_data)
            msg = Message.new
            msg.body = msg_data['body']
            msg.number = msg_data['number']
            msg.chat = Chat.find(msg_data['chat_id'])
            msg.save!
            puts "Message saved successfully " + msg.inspect
        end
        ack!
    end
end