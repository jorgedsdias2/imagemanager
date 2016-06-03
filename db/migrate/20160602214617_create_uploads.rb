class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :file_name
      t.string :content_type
      t.integer :file_size
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end
  end
end
