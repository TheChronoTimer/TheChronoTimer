# Relação de valores e descontos
#
#		x	<	1000	0%
# 1000	=>	x	<	3000	3%
# 3000	=>	x	<	5000	5%
# 5000	=>	x			8%

# Observações Nada Úteis:

# Eu odeio a falta de ';'
# Por que eu não sei nomear variáveis?
# Que nome decepcionante a sub-rotina de pergunta
# C é mais legal
# Switch-Case é mais organizado

#Post Scriptum:
#Parece pouco, mas organizar comentários cansa
#Inferno ter que ficar no pc por horas
#print("Livre, finalmente")
#Aé, tem que passar pro Word

# Sub-rotinas:
# Kibei do professor porque achei útil
def maisQ0(entrada, val):
	x = int(input(entrada))
	while val > x:
		x = int(input(entrada))
	return x

# Rotina Principal:

#opening
print("\nBem vindo ao Mercado do Nicolas Bauermann!\n")

#input
vUnit = maisQ0("Qual o valor do produto? ", 0)
qtde = maisQ0("Qual a quantidade? ", 0)

#logik pt 1
vTotal = vUnit*qtde

#parte que ficaria mais organizada em um switch-case, mas que serve para escolher um desconto
if vTotal < 1000:
	porc = 0
elif vTotal >= 1000 and vTotal < 3000:
	porc = 0.03
elif vTotal >= 3000 and vTotal < 5000:
	porc = 0.05
elif vTotal >= 5000:
	porc = 0.08
else:
	porc = 0

#logik pt 2
desconto = (vTotal*porc)

#output
print("\nO valor total é de: R$ {}\nO valor a ser pago é de: R$ {}\nO desconto foi de: {}%\nO valor do desconto foi de: R$ {}\n".format(vTotal, vTotal-desconto, porc*100, desconto))
