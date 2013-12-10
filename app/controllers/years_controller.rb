class YearsController < ApplicationController
	def new
		@year = Year.new year: Date.today.year
	end

	def create
		@year = Year.create! year: params[:year][:year]

		Account.all.each do |account|
			residual = params["residual_#{account.tag}"]
			Budget.create! year: @year, account: account, residual: residual if residual
		end

		Agency.all.each do |agency|
			workforce = params["workforce_#{agency.id}"]
			Staff.create! year: @year, agency: agency, number: workforce if workforce
		end

		redirect_to :admin
	rescue Exception => e
		flash[:error] = e.message
		render action: :new
	end

	def edit
		@year = Year.find_by_year params[:id]
	end

	def update
		@year = Year.find_by_year params[:id]
		@year.update! params.require(:year).permit(:year)

		Account.all.each do |account|
			residual = params["residual_#{account.tag}"]
			Budget.get(@year, account).update_attribute! :residual, residual
		end

		Agency.all.each do |agency|
			workforce = params["workforce_#{agency.id}"]
			Staff.get(@year, agency).update_attribute! :number, workforce
		end

		redirect_to :admin
	rescue Exception => e
		flash[:error] = e.message
		render action: :edit
	end

	def destroy
		Year.find_by_year(params[:id]).destroy
	rescue Exception => e
		flash[:error] = e.message
	ensure
		redirect_to :admin
	end
end
