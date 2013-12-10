class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :number
      t.belongs_to :agency
      t.belongs_to :year

      t.timestamps
    end

	add_foreign_key :staffs, :agencies, dependent: :delete
	add_foreign_key :staffs, :years, dependent: :delete

	add_index :staffs, :agency_id
	add_index :staffs, :year_id
	add_index :staffs, [:agency_id, :year_id], unique: true
  end
end
