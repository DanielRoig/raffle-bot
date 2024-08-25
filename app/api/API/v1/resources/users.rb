module API
  module V1
    module Resources
      class Users < Grape::API
        DESCRIPTION = 'End-points related with users'.freeze

        helpers do
          def ensure_user
            @User = User.find_by(id: params[:id])
            if @User.blank?
              raise API::Exceptions::ResourceNotFound,
                    "User with id #{params[:id]} not found"
            end
          end

          def ensure_email
            @User = User.find_by(email: params[:email])

            unless @User.nil?
              raise API::Exceptions::InvalidOperation,
                    'User email already exist'
            end
          end
        end

        namespace 'users', desc: DESCRIPTION do
          desc 'Returns all users',
               http_codes: [
                 {
                   code: 200,
                   model: API::V1::Entities::User
                 }
               ],
          ignore_defaults: true

          get do
            users = User.order(created_at: :desc).all

            status :ok
            present users, with: API::V1::Entities::User
          end

          desc 'Delete user',
               http_codes: [
                 {
                   code: 204,
                   model: API::V1::Entities::User
                 }
               ],
          ignore_defaults: true

          params do
            requires :id, type: Integer
          end

          delete ':id' do
            ensure_user
            user = User.find(params[:id]).destroy

            status 204
          end

          desc 'Create user',
               http_codes: [
                 {
                   code: 201
                 }
               ],
          ignore_defaults: true

          params do
            requires :first_name, type: String
            requires :last_name, type: String
            requires :email, type: String
            requires :description, type: String
          end

          post do
            ensure_email

            user = ::Users::CreateService.call(
              first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], description: params[:description]
            )
            status :created

            present user, with: API::V1::Entities::User
          end

          desc 'Update user',
               http_codes: [
                 {
                   code: 201
                 }
               ],
          ignore_defaults: true

          params do
            optional :description, type: String
          end

          put ':id' do
            ensure_user

            user = ::Users::UpdateService.call(id: params[:id],
description: params[:description])
            status :ok
            present user, with: API::V1::Entities::User
          end
        end
      end
    end
  end
end
