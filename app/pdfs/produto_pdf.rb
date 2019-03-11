class ProdutoPdf < Prawn::Document
	def initialize(produto, view)
		super(top_margin: 70)
		@produtos = produto
		@view = view
		titulo_relatorio
		tabela_produtos
	end

	def titulo_relatorio
		text "Relatório de Estoque", size: 30, style: :bold, align: :center
	end

	def tabela_produtos
		move_down 20
		table tabela_produto_rows do 
			row(0).front_style = :bold
			columns(1..6).align = :center
			self.cell_style = {size: 10}
			self.position = :center
			self.row_colors = ["DDDDDD", "FFFFFF"]
			self.header = true
		end
	end

	def tabela_produto_rows
		[["PRODUTO", "R$ de COMPRA", "R$ de VENDA", "ESTOQUE"]] +
		@produtos.map do |produto|
			[produto.nome, formatavalor(produto.precocompra), formatavalor(produto.precovenda), produto.estoque]
			
		end
	end

	def formatavalor(valor)
		@view.number_to_currency(valor, unit: "R$", separator: ",", delimiter: ".")		
	end

end