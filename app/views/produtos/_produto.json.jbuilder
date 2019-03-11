json.extract! produto, :id, :nome, :descricao, :precocompra, :precovenda, :estoque, :created_at, :updated_at
json.url produto_url(produto, format: :json)