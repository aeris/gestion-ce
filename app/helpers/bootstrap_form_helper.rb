module BootstrapFormHelper
	def text_field_prepend_tag(image, name, value = nil, options = {})
		prependize(image, options) { text_field_tag(name, value, options) }
	end

	def password_field_prepend_tag(name, value = nil, options = {})
		prependize('icon-lock', options) { password_field_tag(name, value, options) }
	end

	def email_field_prepend_tag( name, value = nil, options = {})
		prependize('icon-envelop', options) { email_field_tag(name, value, options) }
	end

	def text_field_label_tag(name, value = nil, options = {})
		labelize(name) { text_field_tag(name, value, options) }
	end

	def amount_field_label_tag(name, value = nil, options = {})
		labelize_and_appendize(I18n.t('number.currency.format.unit'), name, options.merge(type: :text)) do
			text_field_tag name, value, options
		end
	end

	def select_label_tag(name, value = nil, options = {})
		labelize(name) { select_tag(name, value, options) }
	end

	private
	def add_on (image, options = {})
		case options[:type]
			when :img then @template.image_tag image
			when :text then image
			else content_tag :i, nil, class: image
		end
	end

	def prependize(image, options = {})
		content_tag :div, class: %w(control-group) do
			content_tag :div, class: %w(input-prepend) do
				concat(content_tag(:span, class: %w(add-on)) { add_on(image, options) })
				concat yield
			end
		end
	end

	def appendize(image, options = {})
		content_tag :div, class: %w(control-group) do
			content_tag :div, class: %w(input-append) do
				concat yield
				concat(content_tag(:span, class: %w(add-on)) { add_on(image, options) })
			end
		end
	end

	def labelize(name)
		content_tag :div, class: %w(control-group) do
			concat(label_tag(name, t("form.label.#{name}"), class: %w(control-label)))
			concat(content_tag(:div, class: %w(controls)) { yield })
		end
	end

	def labelize_and_appendize(image, name, options = {})
		labelize(name) { appendize(image, options) { yield } }
	end
end
