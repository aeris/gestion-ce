class Entry < ActiveRecord::Base
	CATEGORIES = [:check, :card, :transfer, :cash]
	STATES = [:new, :send]
	STATES.concat STATES.collect &:to_s

	belongs_to :agency
	belongs_to :budget
	belongs_to :activity
	has_one :account, through: :budget
	validates_presence_of :amount, :category, :date, :to, :state
	validates_inclusion_of :state, in: STATES

	before_validation do
		self.state ||= :new
	end

	def self.total entries
		entries.map(&:amount).inject(0, :+)
	end

	def debit?
		self.amount < 0
	end

	def credit?
		self.amount > 0
	end
end
