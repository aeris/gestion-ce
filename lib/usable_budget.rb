module UsableBudget
	def remaining budget
		self.available(budget) - self.used(budget)
	end

	def percentage budget
		available = self.available budget
		available == 0 ? 100 : (self.remaining(budget) / available * 100).floor
	end
end
