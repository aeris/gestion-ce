module BooleanHelper
	def to_bool(name)
		parse_bool params[name]
	end

	private
	def parse_bool(value)
		case value
			when TrueClass, FalseClass then value
			when String then value =~ /^(true|t|yes|y|1)$/i ? true : false
			when NilClass then false
		end
	end
end
