class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.string :user
      t.text :content

      t.timestamps
    end
  end
end
