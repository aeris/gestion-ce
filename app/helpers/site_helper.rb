module SiteHelper
	def agency_progress_bar agency, budget
		progress_bar agency.percentage(budget), 25, 50
	end

	def budget_progress_bar budget
		progress_bar budget.percentage, 25, 50
	end
end
