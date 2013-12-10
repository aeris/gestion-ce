class CreateAccounts < ActiveRecord::Migration
	def change
		create_table :accounts do |t|
			t.string :name, null: false
			t.string :tag, null: false
			t.string :number, null: false

			t.timestamps
		end

		add_index :accounts, :tag, unique: true
	end
end
