# Sem paciencia pra comentar coisa legal

#valor
valor = ((1.1, 1, 0.4, 0.2), (10, 25, 0))

#serve pra escolher o serviço
def escolha_servico():
	x = 0	
	print("Digitalização (DIG)\nImpressão Colorida (ICO)\nImpressão Preto e Branco (IBO)\nFotocópia (FOT)\n")
	while x != "DIG" and x != "ICO" and x != "IBO" and x != "FOT":
		x = input("Qual serviço irá escolher? ")
	return x

#converte em número - mais fácil de usar na tupla
def troca(x):
	if x == "DIG":
		return 0
	elif x == "ICO":
		return 1
	elif x == "IBO":
		return 2
	elif x == "FOT":
		return 3
	else:
		print("Sem paciência para fazer um easter-egg mais legal")

#pega as páginas e valida
def num_pagina():
	x = 0
	while True:
		try:
			x = input("Quantas páginas? ")
			a = x.isdigit()
		except a == False:
			print("Valor incorreto")
		else:
			x = int(x)
			if x >= 10000:
				print("Valor alto demais")
				continue
			return x
			break

#o mesmo que o serviço
def servico_extra():
	x = 'zero'
	print("Encadernação Simples (0)\nEncadernação de Capa Dura (1)\nNada (2)\n")
	while x != '0' and x != '1' and x != '2':
		x = input("Qual adicional irá escolher? ")
	if x.isdigit() == True:
		x = int(x)
	return x

#calcula o desconto
def desc(x):
	if x < 10:
		return 1
	elif x < 100:
		return 0.9
	elif x < 1000:
		return 0.85
	elif x < 10000:
		return 0.8
	else:
		print("Bem-vindo ao mais novo easter-egg impossível de se executar!!!")

#oi
print("\nBem vindo ao serviço de xerox do Nicolas Bauermann!\n")

#lógica
serv = valor[0][troca(escolha_servico())]
print("O serviço escolhido custa: R$ {} a página".format(serv))
pag = num_pagina()
pag0 = pag*(desc(pag)) # '0' adicionado pra eu não ter que fazer um reversor de desconto
extra = valor[1][servico_extra()]
#fórmula requerida
total = (serv * pag0) + extra

#improviso pra exigência 4/4
if serv == 1.1:
	var1 = "DIG"
elif serv == 1:
	var1 = "ICO"
elif serv == 0.4:
	var1 = "IBO"
elif serv == 0.2:
	var1 = "FOT"
else:
	print("Não foi legal isso.")
var2 = pag
if extra == 10:
	var3 = "Encadernação Simples"
elif extra == 25:
	var3 = "Encadernação de Capa Dura"
elif extra == 0:
	var3 = "Nenhum"
else:
	print("Isso DEFINITIVAMENTE não foi legal.")

#output
print ("O valor total é de: R$ {}".format(total))
print ("\nServiço escolhido: {}\nQtde. de páginas: {}\nServiço Extra: {}".format(var1, var2, var3)) #socorro, edição de última hora, percebido após o Post Scriptum O_O
#fim
