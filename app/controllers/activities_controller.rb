class ActivitiesController < ApplicationController
        def index
                @year = params[:year].nil? ? Year.current : Year.find_by_year(params[:year])
                @agencies = params[:agency].nil? ? Agency.all : [Agency.find_by_tag(params[:agency])]
        end

        def create
                @activity = Activity.new params.require(:activity).permit(:description, :date, :plan_debit, :plan_credit, :agency_id, :year_id)
                @activity.save!
		redirect_to root_path
	rescue Exception => e
		flash[:error] = e.message
		render :new
	end

	def show
		@activity = Activity.find params[:id]
		@entry = Entry.new date: Date.today, activity: @activity, agency: @me.agency, budget: @activity.year.budget(:social)
	end

	def edit
		@activity = Activity.find params[:id]
		render :new
	end

	def update
		@activity = Activity.find params[:id]
		@activity.update! params.require(:activity).permit(:description, :date, :plan_debit, :plan_credit, :agency_id, :year_id)
		redirect_to root_path
	rescue Exception => e
		flash[:error] = e.message
		render :new
	end

	def close
		@activity = Activity.find params[:id]
		@activity.toggle! :closed
		redirect_to @activity
	end

	def destroy
		Activity.find(params[:id]).destroy!
	rescue Exception => e
		flash[:error] = e.message
	ensure
		redirect_to root_path
	end
end
