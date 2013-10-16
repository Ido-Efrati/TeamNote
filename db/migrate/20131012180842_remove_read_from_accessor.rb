class RemoveReadFromAccessor < ActiveRecord::Migration
  def change
  	  	remove_column :accessors, :can_read, :boolean
  	  	remove_column :accessors, :can_edit, :boolean
  	  	add_column :accessors, :access_rights, :boolean

  end
end
