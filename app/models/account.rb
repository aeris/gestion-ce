class Account < ActiveRecord::Base
	has_many :entries, inverse_of: :account, dependent: :delete_all
	has_many :budgets, inverse_of: :account, dependent: :delete_all
	validates_presence_of :name, :number, :tag
	validates_uniqueness_of :tag
	def self.get tag
		self.find_by_tag tag
	end

	def to_param
		self.tag
	end
end
