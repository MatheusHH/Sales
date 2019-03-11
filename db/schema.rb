# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20171117193246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categorias", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clientes", force: :cascade do |t|
    t.string   "nome"
    t.string   "telefone"
    t.string   "cpf"
    t.string   "endereco"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contas", force: :cascade do |t|
    t.string   "vencimento"
    t.string   "pagamento"
    t.decimal  "valor"
    t.integer  "entrada_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contas", ["entrada_id"], name: "index_contas_on_entrada_id", using: :btree

  create_table "entradas", force: :cascade do |t|
    t.integer  "nf"
    t.decimal  "valortotal"
    t.decimal  "decimal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "fornecedor_id"
  end

  add_index "entradas", ["fornecedor_id"], name: "index_entradas_on_fornecedor_id", using: :btree

  create_table "fornecedores", force: :cascade do |t|
    t.string   "nome"
    t.string   "cnpj"
    t.string   "endereco"
    t.string   "telefone"
    t.string   "contato"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "modalidades", force: :cascade do |t|
    t.string   "nome"
    t.decimal  "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pedidos", force: :cascade do |t|
    t.integer  "cliente_id"
    t.string   "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pedidos", ["cliente_id"], name: "index_pedidos_on_cliente_id", using: :btree

  create_table "prodentradas", force: :cascade do |t|
    t.integer  "entrada_id"
    t.integer  "produto_id"
    t.integer  "quantidade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "prodentradas", ["entrada_id"], name: "index_prodentradas_on_entrada_id", using: :btree
  add_index "prodentradas", ["produto_id"], name: "index_prodentradas_on_produto_id", using: :btree

  create_table "produtos", force: :cascade do |t|
    t.string   "nome"
    t.string   "descricao"
    t.decimal  "precocompra"
    t.decimal  "decimal"
    t.decimal  "precovenda"
    t.integer  "estoque"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "categoria_id"
  end

  add_index "produtos", ["categoria_id"], name: "index_produtos_on_categoria_id", using: :btree

  create_table "recebimentos", force: :cascade do |t|
    t.integer  "pedido_id"
    t.decimal  "valor"
    t.decimal  "decimal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "vencimento"
    t.string   "pagamento"
  end

  add_index "recebimentos", ["pedido_id"], name: "index_recebimentos_on_pedido_id", using: :btree

  create_table "useres", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "subdomain"
  end

  add_index "useres", ["email"], name: "index_useres_on_email", unique: true, using: :btree
  add_index "useres", ["reset_password_token"], name: "index_useres_on_reset_password_token", unique: true, using: :btree

  create_table "vendas", force: :cascade do |t|
    t.integer  "pedido_id"
    t.integer  "produto_id"
    t.integer  "quantidade"
    t.decimal  "valortotal"
    t.decimal  "decimal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.decimal  "valortarifa"
    t.decimal  "valoreceber"
    t.decimal  "valorcomissao"
    t.integer  "vendedor_id"
    t.integer  "modalidade_id"
  end

  add_index "vendas", ["modalidade_id"], name: "index_vendas_on_modalidade_id", using: :btree
  add_index "vendas", ["pedido_id"], name: "index_vendas_on_pedido_id", using: :btree
  add_index "vendas", ["produto_id"], name: "index_vendas_on_produto_id", using: :btree
  add_index "vendas", ["vendedor_id"], name: "index_vendas_on_vendedor_id", using: :btree

  create_table "vendedores", force: :cascade do |t|
    t.string   "nome"
    t.string   "telefone"
    t.decimal  "porcentagem"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "contas", "entradas"
  add_foreign_key "entradas", "fornecedores"
  add_foreign_key "pedidos", "clientes"
  add_foreign_key "prodentradas", "entradas"
  add_foreign_key "prodentradas", "produtos"
  add_foreign_key "produtos", "categorias"
  add_foreign_key "recebimentos", "pedidos"
  add_foreign_key "vendas", "modalidades"
  add_foreign_key "vendas", "pedidos"
  add_foreign_key "vendas", "produtos"
  add_foreign_key "vendas", "vendedores"
end
