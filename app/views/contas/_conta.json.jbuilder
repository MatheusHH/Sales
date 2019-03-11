json.extract! conta, :id, :vencimento, :pagamento, :valor, :entrada_id, :created_at, :updated_at
json.url conta_url(conta, format: :json)