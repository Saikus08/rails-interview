class AddTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, default: 0
      t.datetime :due_date

      t.timestamps
    end

    add_index :todo_lists, :status
    add_index :todo_lists, :due_date
  end
end
