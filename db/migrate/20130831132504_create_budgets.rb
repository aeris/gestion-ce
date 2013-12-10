class CreateBudgets < ActiveRecord::Migration
	def change
		create_table :budgets do |t|
			t.float :residual, null: false
			t.belongs_to :year, null: false
			t.belongs_to :account, null: false

			t.timestamps
		end

		add_foreign_key :budgets, :years, dependent: :delete
		add_foreign_key :budgets, :accounts, dependent: :delete

		add_index :budgets, :year_id
		add_index :budgets, :account_id
		add_index :budgets, [:year_id, :account_id], unique: true
	end
end
