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

ActiveRecord::Schema.define(version: 20190528053818) do

  create_table "conta", force: :cascade do |t|
    t.float "valor"
    t.float "juros"
    t.string "status"
    t.string "dataCompra"
    t.string "dataPagamento"
    t.integer "funcionario"
    t.integer "cliente"
    t.string "descricao"
    t.string "comprador"
    t.string "parentesco"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome"
    t.string "cpf"
    t.string "telefone"
    t.string "celular"
    t.string "email"
    t.string "senha"
    t.string "cidade"
    t.string "rua"
    t.string "numero"
    t.string "cargo"
    t.integer "tipo"
    t.integer "inativo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
