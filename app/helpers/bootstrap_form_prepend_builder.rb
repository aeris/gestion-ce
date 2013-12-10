class BootstrapFormPrependBuilder < BootstrapFormBuilder
	def text_field_prepend(image, attribute, options = {})
		prependize('text_field', image, attribute, options)
	end

	def email_field_prepend(attribute, options = {})
		prependize('email_field', 'icon-envelope', attribute, options)
	end

	def password_field_prepend(attribute, options = {})
		prependize('password_field', 'icon-lock', attribute, options)
	end

	def amount_field_prepend(attribute, options = {})
		prependize('text_field', I18n.t('number.currency.format.unit'), attribute, options)
	end

	private
	def prependize(field_type, image, attribute, options = {})
		img = case options[:type]
			when :img then @template.image_tag image
			when :text then image
			else @template.content_tag :i, nil, class: image
		end

		classes = %w(control-group)
		classes << 'error' if @object.errors[object_name].any?
		@template.content_tag :div, class: classes do
			@template.content_tag :div, class: %w(input-prepend) do
				@template.concat @template.content_tag(:span, class: %w(add-on)) { img }
				@template.concat self.send(field_type, attribute, options)
			end
		end
	end
end
