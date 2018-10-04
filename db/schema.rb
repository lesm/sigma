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

ActiveRecord::Schema.define(version: 2018_10_04_193954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adeudos", force: :cascade do |t|
    t.decimal "anticipo", default: "0.0"
    t.decimal "monto", default: "0.0"
    t.boolean "liquidado", default: false
    t.bigint "cajero_id"
    t.bigint "arqueo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arqueo_id"], name: "index_adeudos_on_arqueo_id"
    t.index ["cajero_id"], name: "index_adeudos_on_cajero_id"
  end

  create_table "arqueos", force: :cascade do |t|
    t.decimal "monto_sistema", default: "0.0"
    t.text "observacion"
    t.bigint "cierre_caja_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "monto_cajero", default: "0.0"
    t.index ["cierre_caja_id"], name: "index_arqueos_on_cierre_caja_id"
  end

  create_table "cierre_cajas", force: :cascade do |t|
    t.decimal "monto_sistema", default: "0.0"
    t.text "observacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "abierta", default: true
    t.decimal "monto_cajero", default: "0.0"
    t.bigint "cajero_id"
    t.index ["cajero_id"], name: "index_cierre_cajas_on_cajero_id"
  end

  create_table "comprobantes", force: :cascade do |t|
    t.string "serie"
    t.string "folio"
    t.string "moneda", default: "MXN"
    t.string "tipo_comprobante"
    t.string "lugar_expedicion"
    t.string "metodo_pago", default: "Pago en una sola exhibición"
    t.string "forma_pago"
    t.money "subtotal", scale: 2, default: "0.0"
    t.money "descuento", scale: 2, default: "0.0"
    t.money "total", scale: 2, default: "0.0"
    t.string "type"
    t.string "cbb"
    t.string "xml"
    t.string "pdf"
    t.string "estado"
    t.text "respuesta_timbrado"
    t.string "motivo_descuento"
    t.datetime "fecha_emision"
    t.text "observaciones"
    t.bigint "cajero_id"
    t.bigint "contribuyente_id"
    t.bigint "emisor_id"
    t.bigint "arqueo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arqueo_id"], name: "index_comprobantes_on_arqueo_id"
    t.index ["cajero_id"], name: "index_comprobantes_on_cajero_id"
    t.index ["contribuyente_id"], name: "index_comprobantes_on_contribuyente_id"
    t.index ["emisor_id"], name: "index_comprobantes_on_emisor_id"
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
    t.bigint "cajero_id"
    t.index ["cajero_id"], name: "index_contribuyentes_on_cajero_id"
  end

  create_table "cuentas", force: :cascade do |t|
    t.string "codigo", null: false
    t.string "descripcion", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dineros", force: :cascade do |t|
    t.integer "diez_centavos", default: 0
    t.integer "veinte_centavos", default: 0
    t.integer "cincuenta_centavos", default: 0
    t.integer "un_peso", default: 0
    t.integer "dos_pesos", default: 0
    t.integer "cinco_pesos", default: 0
    t.integer "diez_pesos", default: 0
    t.integer "veinte_pesos", default: 0
    t.integer "veinte_m_pesos", default: 0
    t.integer "cincuenta_pesos", default: 0
    t.integer "cien_pesos", default: 0
    t.integer "doscientos_pesos", default: 0
    t.integer "quinientos_pesos", default: 0
    t.integer "mil_pesos", default: 0
    t.integer "dos_mil_pesos", default: 0
    t.money "total", scale: 2, default: "0.0"
    t.bigint "arqueo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arqueo_id"], name: "index_dineros_on_arqueo_id"
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
    t.string "logotipo"
    t.string "regimen_fiscal", default: "Personas morales con fines no lucrativos"
    t.string "registro_patronal"
    t.string "eslogan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "escudo"
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
    t.string "type"
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["username"], name: "index_usuarios_on_username", unique: true
  end

  add_foreign_key "adeudos", "arqueos"
  add_foreign_key "adeudos", "usuarios", column: "cajero_id"
  add_foreign_key "arqueos", "cierre_cajas"
  add_foreign_key "cierre_cajas", "usuarios", column: "cajero_id"
  add_foreign_key "comprobantes", "arqueos"
  add_foreign_key "comprobantes", "contribuyentes"
  add_foreign_key "comprobantes", "emisores"
  add_foreign_key "comprobantes", "usuarios", column: "cajero_id"
  add_foreign_key "contribuyentes", "usuarios", column: "cajero_id"
  add_foreign_key "dineros", "arqueos"
end
