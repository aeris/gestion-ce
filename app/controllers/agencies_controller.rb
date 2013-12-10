class AgenciesController < ApplicationController
	def create
		Agency.create! params.require(:agency).permit(:name)
	rescue Exception => e
		flash[:error] = e.message
	ensure
		redirect_to :admin
	end

	def destroy
		Agency.find_by_tag(params[:id]).destroy!
	rescue Exception => e
		flash[:error] = e.message
	ensure
		redirect_to :admin
	end
end
