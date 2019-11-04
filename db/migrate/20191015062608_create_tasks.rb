# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline
      t.integer :position
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
