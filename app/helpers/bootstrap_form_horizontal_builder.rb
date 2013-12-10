class BootstrapFormHorizontalBuilder < BootstrapFormBuilder
	%w(text_field email_field password_field).each do |selector|
		class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
			def #{selector}(method, options = {})
				labelize(method) { super }
			end

			def #{selector}_prepend(image, method, options = {})
				labelize(method) { super(image, method, options) }
			end
		RUBY_EVAL
	end

	def select(method, choices, options = {}, html_options = {})
		labelize(method) { super }
	end

	def amount_field(method, options = {})
		labelize_and_appendize(I18n.t('number.currency.format.unit'), method, options.merge(type: :text)) do
			ActionView::Helpers::FormBuilder.instance_method(:text_field).bind(self).call(method, options)
		end
	end

	def check_box(method, title, options = {}, checked_value = "1", unchecked_value = "0")
		options = objectify_options(options)
		ActionView::Helpers::InstanceTag.new(@object_name, method, self, options.delete(:object)).to_bootstrap_check_box_tag(title, options, checked_value, unchecked_value)
	end

	private
	def labelize(method)
		classes = %w(control-group)
		classes << 'error' if @object.errors[object_name].any?
		@template.content_tag :div, class: classes do
			@template.concat self.label(method, class: %w(control-label))
			@template.concat(@template.content_tag(:div, class: %w(controls)) { yield })
		end
	end

	def add_on (image, options = {})
		case options[:type]
			when :img then
				@template.image_tag image
			when :text then
				image
			else
				@template.content_tag :i, nil, class: image
		end
	end

	def prependize(image, options = {})
		@template.content_tag :div, class: %w(input-prepend) do
			@template.concat @template.content_tag(:span, class: %w(add-on)) { add_on(image, options) }
			@template.concat yield
		end
	end

	def appendize(image, options = {})
		@template.content_tag :div, class: %w(input-append) do
			@template.concat yield
			@template.concat @template.content_tag(:span, class: %w(add-on)) { add_on(image, options) }
		end
	end

	def labelize_and_prependize(image, method, options = {})
		labelize(method) { prependize(image, options) { yield } }
	end

	def labelize_and_appendize(image, method, options = {})
		labelize(method) { appendize(image, options) { yield } }
	end
end
