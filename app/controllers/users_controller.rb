class UsersController < InheritedResources::Base

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :image_url, :bio, :role, :subdomain)
    end

end
