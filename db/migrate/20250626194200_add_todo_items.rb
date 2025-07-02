class AddTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :title, null: false
      t.string :description
      t.integer :status, default: 0
      t.references :todo_list
    end
  end
end
