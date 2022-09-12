class Api::ChatsController < ApplicationController

    before_action :set_application
    before_action :set_chat, only: [:show, :update, :destroy]

    def index
        if @application.present?
            @chats = @application.chats.order("id desc")
            render json: {
                status: 200, data: @chats.as_json(
                only: [:number, :messages_count, :created_at],
                :include => {:messages => {only: [:number, :body, :created_at]}})
            }, status: :ok
        else
            render json: {status: 422, error: {message: ErrorController.invalid_token()}}, status: :unprocessable_entity
        end
    end

    def create
        if @application.present?
            @chat = @application.chats.build
            @chat.number = get_chat_number
            if @chat.valid?
                PublishService.publish("chats", @chat)
                render json: {status: 201, data: @chat.as_json(only: [:number])}, status: :created
            else
                render json: {status: 422, error: @chat.error}, status: :unprocessable_entity
            end
        else
            render json: {status: 422, error: {message: ErrorController.invalid_token()}}, status: :unprocessable_entity
        end
    end

    def destroy

        if @application.present?
            if @chat.present?
                @chat.destroy
                render json: {status: 200, data: {message: "Deleted Successfully chat #" + @chat.number.to_s + " on application #" + @application.token.to_s}}, status: :ok
            else
                render json: {status: 422, error: {message: ErrorController.invalid_chat_number()}}, status: :unprocessable_entity
            end
        else
            render json: {status: 422, error: {message: ErrorController.invalid_token()}}, status: :unprocessable_entity
        end
    end

    private

        def set_application
            @application = Application.find_by(token: params[:token])
        end

        def set_chat
            @chat = (@application.present?) ? @application.chats.find_by(number: params[:number]) : []
        end

        def get_chat_number
            @redis = RedisService.new()
            @number = @redis.get("application_#{@application.token}_chat_number")
            if !@number
                @redis.set("application_#{@application.token}_chat_number", 1)
                @number = 1
            end 
            @redis.increment("application_#{@application.token}_chat_number")
            @number
        end

end