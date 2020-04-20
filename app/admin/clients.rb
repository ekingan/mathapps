ActiveAdmin.register Client do
  permit_params :first_name,:last_name, :date_of_birth, :email, :phone, :street, :city, :state, :zip_code, :occupation, :user_id

  index do
    selectable_column
    id_column
    column :full_name
    column :email
    column :user_id
    actions
  end
end
