class CreateYears < ActiveRecord::Migration
	def change
		create_table :years do |t|
			t.integer :year, null: false

			t.timestamps
		end

		add_index :years, :year, unique: true
	end
end
