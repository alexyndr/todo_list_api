# frozen_string_literal: true

class AddTaskRefToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :task, null: false, foreign_key: true
  end
end
