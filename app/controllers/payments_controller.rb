class PaymentsController < ApplicationController
	def index
		@year = Year.find_by_year params[:year]
	end

	def new
		params[:date] = Date.today
	end

	def create
		p params
		params[:date] = Date.parse params[:date]
		year = Year.find params[:year]
		Account.all.each do |account|
			amount = params[account.tag]
			if amount && !amount.empty?
				budget = Budget.get year, account
				budget.payments.create! amount: amount, date: params[:date]
			end
		end
		redirect_to action: :index, year: year
	rescue Exception => e
		flash[:error] = e.message
		render :new
	end

	def edit
		@payment = Payment.find params[:id]
	end

	def update
		year = Year.find params[:year]
		account = Account.find params[:account]
		budget = Budget.get year, account
		params[:payment][:budget_id] = budget.id
		@payment = Payment.find params[:id]
		@payment.update! params.require(:payment).permit(:date, :amount, :budget_id)
		redirect_to action: :index, year: @payment.year
	rescue Exception => e
		flash[:error] = e.message
		render :edit
	end

	def destroy
		payment = Payment.find(params[:id]).destroy!
	rescue Exception => e
		flash[:error] = e.message
	ensure
		redirect_to :admin
	end
end
