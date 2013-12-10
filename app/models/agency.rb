class Agency < ActiveRecord::Base
	include UsableBudget

	has_many :activities, inverse_of: :agency, dependent: :nullify
	has_many :staffs, inverse_of: :agency, dependent: :delete_all
	validates_presence_of :name, :tag
	validates_uniqueness_of :tag

	before_validation do
		self.tag ||= self.name.downcase
	end

	def employees year
		self.staffs.where(year_id: year).first!.number
	end

	def available budget
		year = budget.year
		(budget.available - budget.common) / year.employees * self.employees(year)
	end

	def used budget
		- Entry.total(Entry.where budget_id: budget, agency_id: self)
	end

	def to_param
		self.tag
	end
end
