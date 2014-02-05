GestionCe::Application.routes.draw do
	get 'login' => 'site#login'
	post 'login' => 'site#auth'
	get 'logout' => 'site#logout'

	get 'admin' => 'site#admin'
	get 'report' => 'site#report'
	get 'balance' => 'site#balance'

	resources :users
	resources :years
	resources :agencies
	resources :activities do
		member do
			get :close
		end
	end
	resources :entries
	resources :payments

	root to: 'site#index'
end
