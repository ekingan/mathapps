ActiveAdmin.register Client do
  permit_params :first_name,:last_name, :date_of_birth, :email, :phone, :street, :city, :state, :zip_code, :occupation, :user_id

  menu priority: 2
  config.sort_order = :last_name_asc

  scope :active, default: true
  scope :all
  scope :inactive

  filter :user_id, as: :select, collection: proc { User.all }
  filter :first_name
  filter :last_name
  filter :email

index do
  selectable_column
  column :last_name
  column :first_name
  column :user, sortable: :user do |client|
    if client.user_id
      User.find(client.user_id).first_name
    else
      client.jobs.map(&:user).map(&:first_name).join(", ")
    end
  end
  actions
end

show do
  columns do
    column do
      panel "Client Info" do
        attributes_table_for client do
          row :first_name
          row :last_name
          row :date_of_birth, as: :datepicker, datepicker_options: { dateFormat: "mm/dd/yy" }
          row :email
          row :phone
          row :occupation
        end
      end
    end
  end
end

  form do |f|
    f.inputs "Client Info" do
      f.input :first_name
      f.input :last_name
      f.input :user_id, as: :select, collection: User.all.map { |u| u.full_name }
      f.input :date_of_birth, as: :datepicker, datepicker_options: { dateFormat: "mm/dd/yy" }
      f.input :email
      f.input :phone
      f.input :entity_type
      f.input :occupation
    end
    f.actions
  end
end
