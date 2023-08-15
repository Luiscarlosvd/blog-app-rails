class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :posts, null: false, foreign_key: true

      t.timestamps
    end
    add_index :comments, :posts
  end
end
