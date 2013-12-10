class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :name, null: false
			t.string :surname, null: false
			t.string :login, null: false
			t.string :password, null: false
			t.belongs_to :agency, null: false

			t.timestamps
		end

		add_foreign_key :users, :agencies, dependent: :delete

		add_index :users, :agency_id
		add_index :users, :login, unique: true
	end
end
