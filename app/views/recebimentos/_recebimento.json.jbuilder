json.extract! recebimento, :id, :pedido_id, :vencimento, :pagamento, :valor, :created_at, :updated_at
json.url recebimento_url(recebimento, format: :json)