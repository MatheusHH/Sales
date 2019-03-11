module ApplicationHelper

	def telefoneform(telefone)
		telefonef = "("
		telefonef << telefone[0..1]
		telefonef << ")"
		telefonef << telefone[2..6]
		telefonef << "-"
		telefonef << telefone[7..10]
		telefonef
	end

	def formatadata(data)
		if data.blank? == false
			data = Time.parse(data)
			data.strftime("%d-%m-%Y")
		end
	end

	def cpfform(cpf)
		cpff = ""
		cpff << cpf[0..2]
		cpff << "."
		cpff << cpf[3..5]
		cpff << "."
		cpff << cpf[6..8]
		cpff << "-"
		cpff << cpf[9..11]
		cpff
	end 


end
