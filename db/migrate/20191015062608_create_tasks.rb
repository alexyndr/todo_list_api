class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline
      t.integer :position
      t.boolean :done

      t.timestamps
    end
  end
end
