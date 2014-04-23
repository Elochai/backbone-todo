class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :name
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
