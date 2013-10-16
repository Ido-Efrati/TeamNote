class AddeOwnerToNotes < ActiveRecord::Migration
  def change
  	 add_column :notes, :user_id, :integer
  	 remove_column :notes, :user, :string

  end
end
