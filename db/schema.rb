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

ActiveRecord::Schema.define(version: 2018_09_12_200653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cierre_cajas", force: :cascade do |t|
    t.decimal "monto"
    t.text "observacion"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_cierre_cajas_on_usuario_id"
  end

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
    t.string "direccionable_type"
    t.bigint "direccionable_id"
    t.index ["direccionable_type", "direccionable_id"], name: "index_direcciones_on_direccionable_type_and_direccionable_id"
  end

  create_table "emisores", force: :cascade do |t|
    t.string "nombre"
    t.string "rfc"
    t.string "logo"
    t.string "regimen_fiscal"
    t.string "registro_patronal"
    t.string "lugar_expedicion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "username", null: false
    t.boolean "activo", default: true, null: false
    t.integer "rol", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["username"], name: "index_usuarios_on_username", unique: true
  end

  add_foreign_key "cierre_cajas", "usuarios"
end
