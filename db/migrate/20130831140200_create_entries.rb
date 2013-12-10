class CreateEntries < ActiveRecord::Migration
	def change
		create_table :entries do |t|
			t.date :date, null: false
			t.string :to, null: false
			t.string :description
			t.float :amount, null: false
			t.string :category, null: false
			t.string :state, null: false
			t.string :bank
			t.string :number
			t.belongs_to :budget
			t.belongs_to :agency
			t.belongs_to :activity

			t.timestamps
		end

		add_foreign_key :entries, :budgets, dependent: :delete
		add_foreign_key :entries, :agencies, dependent: :delete
		add_foreign_key :entries, :activities, dependent: :delete

		add_index :entries, :budget_id
		add_index :entries, :agency_id
		add_index :entries, :activity_id
	end
end
