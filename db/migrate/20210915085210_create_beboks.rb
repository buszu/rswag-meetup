# frozen_string_literal: true

class CreateBeboks < ActiveRecord::Migration[6.1]
  def change
    create_table :beboks do |t|
      t.string :name, null: false
      t.string :mood, null: false

      t.timestamps
    end
  end
end
