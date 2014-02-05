class SiteController < ApplicationController
	skip_before_filter :require_login, only: [:login, :auth]

	def index
		@year = self.year
	end

	def login
	end

	def auth
		username = params[:username]
		password = params[:password]
		@me = User.where(login: username, password: User.hash_password(password)).first!
		session[:me] = @me.id
		flash[:success] = t 'Welcome {user}', user: @me.surname
		redirect_to root_path
	rescue
		flash[:error] = t 'Authentication failure'
		redirect_to :login
	end

	def logout
		session.clear
		redirect_to root_path
	end

	def admin
	end

	def balance
		@year = self.year
	end
end
