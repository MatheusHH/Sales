json.extract! venda, :id, :pedido_id, :produto_id, :quantidade, :valortotal, :created_at, :updated_at
json.url venda_url(venda, format: :json)