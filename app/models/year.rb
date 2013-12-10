class Year < ActiveRecord::Base
	has_many :staffs, inverse_of: :year, dependent: :delete_all
	has_many :agencies, through: :staffs
	has_many :budgets, inverse_of: :year, dependent: :delete_all
	has_many :accounts, through: :budgets
	has_many :entries, through: :budgets
	has_many :payments, through: :budgets
	validates_presence_of :year
	validates_uniqueness_of :year

	def self.current
		self.where(year: Date.today.year).first!
	end

	def budget account
		account = Account.find_by_tag account if account.is_a? Symbol
		Budget.where(year_id: self, account_id: account).first!
	end

	def employees
		self.staffs.map(&:number).inject(0, :+)
	end

	def to_param
		self.year.to_s
	end
end
