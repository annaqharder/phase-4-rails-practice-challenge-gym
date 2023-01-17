class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def show
        client = Client.find(params[:id])
        render json: client, include:["memberships"], status: :ok
    end

    def index
        clients = Client.all
        render json: clients, status: :ok
    end

    def update
        client = Client.find(params[:id])
        client.update!(client_params)
        render json: client, status: :accepted
    end

    private

    def client_params
        params.permit(:name, :age)
    end

    def render_not_found(record)
        render json: { errors: "#{record.model} Not Found"}, status: :not_found
    end
end
