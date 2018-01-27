class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.text :overview
      t.integer :employees
      t.integer :tech_team_size
      t.string :website
      t.string :twitter
      t.string :logo
      t.boolean :published

      t.timestamps
    end
  end
end
