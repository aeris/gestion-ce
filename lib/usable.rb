module Usable
	def remaining
		self.available - self.used
	end

	def percentage
		self.available == 0 ? 0 : (self.remaining / self.available * 100).floor
	end
end
