class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :desc
      t.date :deadline
      t.boolean :completed
      t.integer :priority
      t.integer :todo_list_id
      t.index :todo_list_id

      t.timestamps
    end
  end
end
