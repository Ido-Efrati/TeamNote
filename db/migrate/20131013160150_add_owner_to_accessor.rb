class AddOwnerToAccessor < ActiveRecord::Migration
  def change
  	add_column :accessors, :access_owner, :integer
  end
end
