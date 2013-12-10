class CreateAgencies < ActiveRecord::Migration
	def change
		create_table :agencies do |t|
			t.string :name, null: false
			t.string :tag, null: false

			t.timestamps
		end

		add_index :agencies, :tag, unique: true
	end
end
