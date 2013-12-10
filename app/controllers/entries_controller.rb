class EntriesController < ApplicationController
	def create
		@entry = Entry.new params.require(:entry).permit(:date, :description, :amount, :category, :number, :bank, :activity_id, :agency_id, :budget_id)
		@entry.save!
		if @entry.activity
			redirect_to @entry.activity
		else
			redirect_to root_path
		end
	rescue Exception => e
		flash[:error] = e.message
		render :new
	end

	def edit
		@entry = Entry.find params[:id]
		render '_entry', locals: {entry: @entry, action: :edit, span: 'span5'}
	end

	def update
		@entry = Entry.find params[:id]
		@entry.update params.require(:entry).permit(:date, :description, :amount, :category, :number, :bank, :activity_id, :agency_id, :budget_id)
		if @entry.activity
			redirect_to @entry.activity
		else
			redirect_to root_path
		end
	rescue Exception => e
		flash[:error] = e.message
		render '_entry', locals: {entry: @entry, action: :edit, span: 'span5'}
	end

	def destroy
		entry = Entry.find(params[:id]).destroy!
		activity = entry.activity
		if activity
			redirect_to activity
		else
			redirect_to root_path
		end
	rescue Exception => e
		flash[:error] = e.message
	end
end
