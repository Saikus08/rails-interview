class AddTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :title, null: false
      t.string :description
      t.integer :status, default: 0
      t.datetime :due_date
      t.references :todo_list, null: false, foreign_key: true

      t.timestamps
    end

    add_index :todo_items, :status
    add_index :todo_items, :due_date
  end
end
