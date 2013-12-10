class Activity < ActiveRecord::Base
	belongs_to :agency
	belongs_to :year
	has_many :entries, inverse_of: :activity, dependent: :nullify
	validates_presence_of :agency, :year

	before_validation do
		self.closed ||= false
		true
	end

	def self.find_open
		self.where closed: false
	end

	def find_open
		activities = Activity.find_open
		activities << self unless activities.include? self
		activities
	end

	def plan_total
		self.plan_credit - self.plan_debit
	end

	def plan_percentage
		self.plan_debit == 0 ? 0 : (1 - self.plan_credit / self.plan_debit) * 100
	end

	def debit
		-Entry.total(self.entries.select &:debit?)
	end

	def credit
		Entry.total self.entries.select &:credit?
	end

	def total
		Entry.total self.entries
	end

	def percentage
		self.debit == 0 ? 0 : (1 - self.credit / self.debit) * 100
	end
end
