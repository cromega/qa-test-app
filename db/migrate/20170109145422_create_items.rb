class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :category
      t.integer :user_id

      t.timestamps
    end
  end
end
