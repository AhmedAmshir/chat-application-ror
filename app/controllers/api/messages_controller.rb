class Api::MessagesController < ApplicationController

    before_action :set_application
    before_action :set_chat
    before_action :set_message, only: [:show, :update, :destroy]

    def index
        @messages = @chat.messages.order("id desc")
        render json: {
            status: 200, data: @messages.as_json(only: [:number, :body, :created_at])
        }, status: :ok
    end

    def create
        @message = @chat.messages.build(message_params)

        if @message.valid?
            @message.number = get_message_number
        
            PublishService.publish("messages", @message)
            render json: {status: 201, data: {message_number: @message.number}}, status: :created
            
        else
            render json: {status: 400, error: @message.errors}, status: :bad_request
        end
    end

    def show
        if @message.present?
            render json: {
                status: 200, data: @message.as_json(only: [:number, :body, :created_at])
            }, status: :ok
        else
            render json: {status: 204, data: []}, status: :no_content
        end
    end

    def update
        if @message.update_attributes(message_params)

            render json: {status: 200, data: @message.as_json(only: [:number, :body])}, status: :ok
        else
            render json: {status: 422, error: @message.error}, status: :unprocessable_entity
        end
    end

    def destroy

        if @chat.present?
            if @message.present?
                @message.destroy
                render json: {status: 200, data: {message: "Deleted Successfully msg #" + @message.number.to_s + " on chat #" + @chat.number.to_s}}, status: :ok
            else
                render json: {status: 422, error: {message: ErrorController.invalid_message_number()}}, status: :unprocessable_entity 
            end    
        else
            render json: {status: 422, error: {message: ErrorController.invalid_chat_number()}}, status: :unprocessable_entity
        end
    end

    def search
        if params['query']
            @messages = Message.search(params['query'], @chat).records
            @result = []
            if @messages
                @messages.each do |msg|
                    m = {
                        number: msg.number,
                        body: msg.body
                    }
                    @result << m
                end
                @result    
            end
            render json: {status: 200, data: @result}, status: :ok
        else
            render json: {status: 400, error: ['Thq `query` param is required.']}, status: :bad_request
        end
    end

    private

        def set_application
            @application = Application.find_by(token: params[:token])
        end

        def set_chat
            @chat = @application.chats.find_by(number: params[:number])
        end

        def set_message
            @message = @chat.messages.find_by(number: params[:msg_number])
        end

        def get_message_number
            @redis = RedisService.new()
            @number = @redis.get("application_#{@application.token}_chat_#{@chat.number}_message_number")
            if !@number
                @redis.set("application_#{@application.token}_chat_#{@chat.number}_message_number", 1)
                @number = 1
            end 
            @redis.increment("application_#{@application.token}_chat_#{@chat.number}_message_number")
            @number
        end

        def message_params
            params.require(:message).permit(:body)
        end 

end