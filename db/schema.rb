# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_09_031437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contribuyentes", force: :cascade do |t|
    t.string "nombre_o_razon_social"
    t.string "primer_apellido"
    t.string "segundo_apellido"
    t.boolean "persona_fisica", default: true
    t.string "email"
    t.string "rfc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "direcciones", force: :cascade do |t|
    t.string "calle"
    t.string "numero"
    t.string "colonia"
    t.string "codigo_postal"
    t.string "localidad"
    t.string "municipio"
    t.string "estado", default: "Oaxaca"
    t.string "pais", default: "México"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contribuyente_id"
    t.index ["contribuyente_id"], name: "index_direcciones_on_contribuyente_id"
  end

  add_foreign_key "direcciones", "contribuyentes"
end
