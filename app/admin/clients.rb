ActiveAdmin.register Client do
  permit_params :first_name,:last_name, :date_of_birth, :email, :phone, :occupation, :user_id, :entity_type,
  spouse_attributes: [:first_name,:last_name, :date_of_birth, :email, :phone, :occupation],
  address_attributes: [:street, :city, :state, :zip_code]

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
  column 'Preparer', :user, sortable: :user_id do |client|
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
      if client.spouse_id.present?
        panel "Spouse Info" do
          attributes_table_for client.spouse do
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
end

  form do |f|
    f.inputs "Client Info" do
      f.semantic_errors
      f.input :first_name
      f.input :last_name
      f.input :user_id, label: 'Preparer', as: :select, collection: User.all.map { |u| [ u.full_name, u.id ] }
      f.input :date_of_birth, as: :datepicker, datepicker_options: { dateFormat: "mm/dd/yy" }
      f.input :email
      f.input :phone
      f.input :entity_type
      f.input :occupation
      f.inputs "Spouse", id: "spouse-form", hidden: true,
        for:  [:spouse, f.object.spouse || f.object.build_spouse] do |s|
        button "Add Spouse", class: 'btn-add-spouse', type: 'button'
        s.input :first_name
        s.input :last_name
        s.input :date_of_birth, as: :datepicker, datepicker_options: { dateFormat: "mm/dd/yy" }
        s.input :email
        s.input :phone
        s.input :occupation
      end
      f.inputs "Address", id: "address-form", hidden: true,
        for: [:address, f.object.address || f.object.build_address] do |a|
        button "Add Address", class: 'btn-add-address', type: 'button'
        a.input :street
        a.input :city
        a.input :state,
          as: :select,
          include_blank: false,
          selected: a.object.country || 'OR',
          input_html: { id: 'address_attributes_state' },
          collection: Mathapps::LOCATIONS[:states]
        a.input :zip_code
      end
    end
    f.actions
  end

  controller do
    def create
      ClientInformation.new(permitted_params).create
      redirect_to admin_clients_path
    end

    def update
      ClientInformation.new(permitted_params).update
      redirect_to admin_client_path(params[:id])
    end
  end
end
