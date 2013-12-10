class CreateActivities < ActiveRecord::Migration
	def change
		create_table :activities do |t|
			t.string :description, null: false
			t.date :date, null: false
			t.float :plan_debit, null: false
			t.float :plan_credit, null: false
			t.boolean :closed, null: false
			t.belongs_to :agency
			t.belongs_to :year, null: false

			t.timestamps
		end

		add_foreign_key :activities, :agencies, dependent: :delete
		add_foreign_key :activities, :years, dependent: :delete

		add_index :activities, :agency_id
		add_index :activities, :year_id
	end
end
