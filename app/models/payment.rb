class Payment < ActiveRecord::Base
	belongs_to :budget
	has_one :year, through: :budget
	has_one :account, through: :budget
	validates_presence_of :amount, :budget, :date
end
