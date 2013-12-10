class CreatePayments < ActiveRecord::Migration
	def change
		create_table :payments do |t|
			t.date :date
			t.float :amount
			t.belongs_to :budget

			t.timestamps
		end

		add_foreign_key :payments, :budgets, dependent: :delete

		add_index :payments, :budget_id
	end
end
