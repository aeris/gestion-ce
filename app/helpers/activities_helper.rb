module ActivitiesHelper
	def activity_progress_bar percentage
		progress_bar percentage, 50, 50, inverse: true
	end
end
