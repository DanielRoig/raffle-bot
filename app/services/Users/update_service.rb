module Users
  class UpdateService
    include Service

    def call
      update_user
      user
    end

    def update_user
      return unless description

      Profile.create!(user: user,
      description: description || last_profile_register.description)
    end

    def last_profile_register
      @last_profile_register ||= user.profile.last
    end

    def user
      @user = User.find(id)
    end

    attr_accessor :id, :description
  end
end
