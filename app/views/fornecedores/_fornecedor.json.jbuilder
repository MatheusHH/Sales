json.extract! fornecedor, :id, :nome, :cnpj, :endereco, :telefone, :contato, :created_at, :updated_at
json.url fornecedor_url(fornecedor, format: :json)