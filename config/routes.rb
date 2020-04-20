class SubdomainConstraint
  def self.matches? request
    subdomains = %w{ www }
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  devise_for :clients, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :users, constraints: { subdomain: 'www' }

  constraints SubdomainConstraint do
    resources :clients
  end
end
