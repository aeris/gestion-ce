module ActionView
	module Helpers
		class InstanceTag
			def to_bootstrap_check_box_tag(title, options = {}, checked_value = "1", unchecked_value = "0")
				options = options.stringify_keys
				options["type"] = "checkbox"
				options["value"] = checked_value
				if options.has_key?("checked")
					cv = options.delete "checked"
					checked = cv == true || cv == "checked"
				else
					checked = self.class.check_box_checked?(value(object), checked_value)
				end
				options["checked"] = "checked" if checked
				if options["multiple"]
					add_default_name_and_id_for_value(checked_value, options)
					options.delete("multiple")
				else
					add_default_name_and_id(options)
				end
				hidden = unchecked_value ? tag("input", "name" => options["name"], "type" => "hidden", "value" => unchecked_value, "disabled" => options["disabled"]) : ""
				checkbox = tag("input", options)
				label = label_tag(options["name"], checkbox + title, class: %w(checkbox))
				(hidden + label).html_safe
			end
		end
	end
end

class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
	def check_box(method, title, options = {}, checked_value = "1", unchecked_value = "0")
		options = objectify_options(options)
		ActionView::Helpers::InstanceTag.new(@object_name, method, self, options.delete(:object)).to_bootstrap_check_box_tag(title, options, checked_value, unchecked_value)
	end

	def select_with_empty(method, choices, options = {}, html_options = {})
		self.select method, choices, options, html_options
	end
end
