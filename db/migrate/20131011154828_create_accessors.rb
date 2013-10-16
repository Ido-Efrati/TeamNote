class CreateAccessors < ActiveRecord::Migration
  def change
    create_table :accessors do |t|
      t.integer :note_id
      t.integer :accessor_id
      t.boolean :can_read
      t.boolean :can_edit

      t.timestamps
    end
  end
end
