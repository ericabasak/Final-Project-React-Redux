class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :is_complete
      t.integer :list_id

      t.timestamps
    end
  end
end
