class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :status
      t.belongs_to :user, index: true

      t.timestamps null: false
      t.index :title, unique: true
    end
  end
end
