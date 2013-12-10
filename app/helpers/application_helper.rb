module ApplicationHelper
	def progress_bar percentage, lvl1 = 25, lvl2 = 50, opts = {}
		classes = %w(bar-danger bar-warning bar-success)
		color = if opts[:inverse]
					if percentage <= lvl1
						classes[2]
					elsif percentage <= lvl2
						classes[1]
					else
						classes[0]
					end
				else
					if percentage < lvl1
						classes[0]
					elsif percentage < lvl2
						classes[1]
					else
						classes[2]
					end
				end
		content_tag :div, class: %w(progress progress-striped) do
			content_tag :div, number_to_percentage(percentage, precision: 0),
						class: ['bar', color], style: "width: #{percentage.round}%;"
		end
	end
end
