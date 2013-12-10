module UsableBudget
	def remaining budget
		self.available(budget) - self.used(budget)
	end

	def percentage budget
		(self.remaining(budget) / self.available(budget) * 100).floor
	end
end
