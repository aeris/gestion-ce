class Budget < ActiveRecord::Base
	include Usable

	belongs_to :year
	belongs_to :account
	has_many :entries, inverse_of: :budget, dependent: :nullify
	has_many :payments, inverse_of: :budget, dependent: :nullify
	validates_presence_of :year, :account
	validates_uniqueness_of :account_id, scope: :year_id

	def self.current account
		self.get Year.current, Account.get(account)
	end

	def self.get year, account
		Budget.where(year_id: year, account_id: account).first!
	end

	def common
		Entry.total(self.entries.where(agency_id: nil))
	end

	def common_debit
		-Entry.total(self.entries.where(agency_id: nil).where('amount < 0'))
	end

	def common_credit
		Entry.total(self.entries.where(agency_id: nil).where('amount > 0'))
	end

	def available
		self.residual + Entry.total(self.payments)
	end

	def used
		-Entry.total(self.entries)
	end
end
