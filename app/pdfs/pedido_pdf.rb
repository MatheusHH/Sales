class PedidoPdf < Prawn::Document
	def initialize(pedido, view)
		super(top_margin: 70)
		@pedido = pedido
		@view = view
		numero_pedido
		titulodadoscliente
		dadoscliente
		titulodevenda
		pedido_venda
		tituloderecebimento
		pedido_recebimento
		valor_total
		assinatura
	end

	def numero_pedido
		text "Pedido Nº #{@pedido.id}", size: 30, style: :bold, align: :center
	end

	def titulodadoscliente
		move_down 20
		text "Dados do Cliente", size: 15, style: :italic, align: :left
	end

	def dadoscliente
		move_down 20
		t = make_table([["Cliente: #{@pedido.cliente.nome}"], 
		["Telefone: #{@pedido.cliente.telefone}"], 
		["CPF: #{@pedido.cliente.cpf}"], 
		["Endereço: #{@pedido.cliente.endereco}"]])
		t.position = :left
		t.column_widths = [530, 530, 530, 530]
		t.row_colors = ["DDDDDD", "FFFFFF"]
		t.draw 

	end

	def titulodevenda
		move_down 50
		text "Dados da Venda", size: 15, style: :italic, align: :left
	end

	def pedido_venda
		move_down 20
		table pedido_venda_rows do 
			row(0).front_style = :bold
			columns(1..6).align = :center
			self.cell_style = {size: 13}
			self.position = :center
			self.row_colors = ["DDDDDD", "FFFFFF"]
			self.header = true
		end
	end

	def tituloderecebimento
		move_down 50
		text "Parcelas de Pagamento", size: 15, style: :italic, align: :left
	end

	def pedido_venda_rows
		[["Vendedor", "Produto", "Modalidade", "Preco Unitário", "Quantidade", "Valor Total"]] +
		@pedido.vendas.map do |item|
			[item.vendedor.nome, item.produto.nome, item.modalidade.nome, formatavalor(item.produto.precovenda), item.quantidade, formatavalor(item.valortotal)]
			
		end
	end

	def pedido_recebimento
		move_down 20
		table pedido_recebimento_rows do 
			row(0).front_style = :bold
			columns(1..3).align = :center
			self.cell_style = {size: 13}
			self.position = :center
			self.row_colors = ["DDDDDD", "FFFFFF"]
			self.header = true
		end
	end

	def pedido_recebimento_rows
		[["    Data de Vencimento   ", "   Data de Pagamento    ", "    Valor / Parcelas     "]] +
		@pedido.recebimentos.map do |item|
			[formatadata(item.vencimento), formatadata(item.pagamento), formatavalor(item.valor)]
			
		end
	end

	def formatavalor(valor)
		@view.number_to_currency(valor, unit: "R$", separator: ",", delimiter: ".")		
	end

	def formatadata(data)
		if data.blank? == false
			data = Time.parse(data)
			data.strftime("%d-%m-%Y")
		end
	end

	def valor_total
		move_down 40
		text "Valor Total: #{formatavalor(@pedido.valor_total)}", size: 20, style: :bold, align: :center
	end

	def assinatura
		move_down 60
		text "------------------------------------------------------------", align: :center
		text "Assinatura", align: :center
	end
end