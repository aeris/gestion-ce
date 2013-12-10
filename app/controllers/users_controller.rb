class UsersController < ApplicationController
	def create
		@user = User.new params.require(:user).permit(:name, :surname, :password)
		@user.agency = Agency.find params[:user][:agency]
		@user.save!
	rescue Exception => e
		flash[:error] = e.message
	ensure
		redirect_to :admin
	end

	def destroy
		User.find(params[:id]).destroy!
	rescue Exception => e
		flash[:error] = e.message
	ensure
		redirect_to :admin
	end
end
