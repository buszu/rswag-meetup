# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_915_085_229) do
  create_table 'beboks', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'mood', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'hearts', force: :cascade do |t|
    t.integer 'bebok_id', null: false
    t.string 'color', null: false
    t.integer 'bpm', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['bebok_id'], name: 'index_hearts_on_bebok_id'
  end

  add_foreign_key 'hearts', 'beboks'
end
