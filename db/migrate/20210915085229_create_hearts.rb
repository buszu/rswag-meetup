# frozen_string_literal: true

class CreateHearts < ActiveRecord::Migration[6.1]
  def change
    create_table :hearts do |t|
      t.references :bebok, null: false, foreign_key: true
      t.string :color, null: false
      t.integer :bpm, null: false

      t.timestamps
    end
  end
end
