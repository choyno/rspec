Rspec::Application.routes.draw do
	devise_for :members

	devise_scope :member do
		root to: "devise/sessions#new"
	end

	authenticated :member do
		root to: "members#dashboard"
	end


		get "dashboard", to: "members#dashboard", as: :dashboard
end
