class CreatePins < ActiveRecord::Migration[5.0]
  def change
    create_table :pins do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :extension
      t.boolean :active

      t.timestamps
    end
  end
end
