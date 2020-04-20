class ClientsController < InheritedResources::Base

  private

    def client_params
      params.require(:client).permit(:first_name, :last_name, :date_of_birth, :email, :phone, :street, :city, :state, :zip_code, :occupation, :user_id, :entity_type, :discontinued)
    end

end
