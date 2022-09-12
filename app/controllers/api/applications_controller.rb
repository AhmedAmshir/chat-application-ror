class Api::ApplicationsController < ApplicationController

    before_action :set_application, only: [:show, :update, :destroy]

    def index
        @applications = Application.order("id desc")
        if @applications
            render json: {
                status: 200, data: @applications.as_json(
                only: [:token, :name, :chats_count, :created_at],
                :include => {:chats => {only: [:number, :messages_count]}})
            }, status: :ok
        else
            render json: {status: 200, data: []}
        end        
    end

    def show
        @application = Application.select(:token, :name, :chats_count).find_by(token: params[:token])
        if @application

            render json: {status: 200, data: @application.as_json(only: [:token, :name, :chats_count])}, status: :ok
        else
            render json: {status: 204, data: []}, status: :no_content
        end
    end

    def create
        @application = Application.new({name: application_params[:name], token: Application.new.create_token})
        if @application.save!

            render json: {status: 201, data: @application.as_json(only: [:token])}, status: :created
        else
            render json: {status: 422, error: @application.error}, status: :unprocessable_entity
        end
    end

    def update
        @application = Application.find_by(token: params[:token])
          
        if @application.update_attributes(application_params)

            render json: {status: 200, data: @application.as_json(only: [:token, :name])}, status: :ok
        else
            render json: {status: 422, error: @application.error}, status: :unprocessable_entity
        end
    end

    def destroy
        @application = Application.find_by(token: params[:token])
        if @application.present?

            @application.destroy
            render json: {status: 200, data: {message: "Deleted Successfully #" +  params[:token].to_s}}, status: :ok
        else
            render json: {status: 422, error: {message: ErrorController.invalid_token(params[:token].to_s)}}, status: :unprocessable_entity
        end
    end

    private

        def set_application
            @application = Application.find_by(token: params[:token])
        end

        def application_params
            params.require(:application).permit(:name)
        end
end