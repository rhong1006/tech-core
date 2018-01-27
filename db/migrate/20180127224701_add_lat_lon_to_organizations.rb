class AddLatLonToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :longitude, :float
    add_column :organizations, :latitude, :float
  end
end
