class ApplicationController < ActionController::Base
	protect_from_forgery
	around_filter :wrap_in_transaction
	before_filter :require_login

	def wrap_in_transaction
		ActiveRecord::Base.transaction do
			yield
		end
	end

	def require_login
		if session[:me]
			@me = User.find session[:me]
		else
			flash[:error] = 'Authentification nécessaire'
			redirect_to login_path
		end
	end
end
