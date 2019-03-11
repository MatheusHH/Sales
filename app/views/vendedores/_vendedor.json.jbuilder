json.extract! vendedor, :id, :nome, :telefone, :porcentagem, :created_at, :updated_at
json.url vendedor_url(vendedor, format: :json)