module Users
  class CreateService
    include Service

    def call
      ActiveRecord::Base.transaction do
        create_user
        create_profile
      end

      @user
    end

    def create_user
      @user = User.create!(first_name: first_name, last_name: last_name,
email: email, password: password)
    end

    def create_profile
      Profile.create!(user: @user, description: description)
    end

    attr_accessor :first_name, :last_name, :email, :password, :description
  end
end
