class PublishService

    def self.publish(queue, message = {})
        @connection ||= BUNNY.tap do |c|
            c.start
        end
        @channel = @connection.create_channel
        @channel.inspect
        publisher = @channel.queue(queue, durable: true)
        publisher.name.inspect
        publisher.publish(message.to_json, routing_key: publisher.name)
    end

end