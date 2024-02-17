# Lógica do Código
#
# /*
#    // AC = CP + 2
#    // Comentário no comentário, no comentário
#    // Essa fórmula nunca será executada :(
# */
# CP(P/10, M/15, G/19)
# AC(P/12, M/17, G/21)

# Oi Nome Catálogo
# go:		Sabor? - "Sabor Inválido. Tente Novamente"
# Tamanho? - Mesmo texto, mas tamanho**
# if/elif :v - Por que AC não pode ser CP +2 ??? Código bem mais curto
# Acumulador p/ Somar Total
# "Deseja pedir mais alguma coisa?" goto go, else print Acumulador
# Usar todas as frescuras (while, break, continue)

# Pré-Configurações

valor = ((10, 15, 19), (12, 17, 21)) #tupla
soma = 0 #acumulador

#upgrade da versão anterior - ex. 1
def nameOK(entrada, erro, txt1, txt2, txt3 = 0):
	x = 'zero'
	while x != txt1 and x != txt2 and x != txt3:
		x = input(entrada)
		if True != (x == txt1 or x == txt2 or x == txt3):
			print(erro)
	return x

# Código Principal

#hello
print("Seja bem-vindo à banca do Nicolas Bauermann!\n\n+----------------+\n|    Catálogo    |\n+----------------+\n| Açaí | Cupuaçú |\n|------+---------|\n| P 12 | P 10    |\n| M 17 | M 15    |\n| G 21 | G 19    |\n+----------------+\n\n")

#repete
while True:
	#cardápio
	sabor = nameOK("Que sabor deseja? Açaí (AC) ou Cupuaçú (CP): ", "Sabor inválido. Tente novamente", "AC", "CP")
	tamanho = nameOK("Qual o tamanho desejado? (P/M/G): ", "Tamanho inválido. Tente novamente", "P", "M", "G")

	#converte em números, para acessar na tupla - estou reaproveitando as variáveis
	if sabor == "CP":
		sabor = 0
	elif sabor == "AC":
		sabor = 1
	else:
		print("Como é que você chegou aqui??") #easter-egg

	if tamanho == "P":
		tamanho = 0
	elif tamanho == "M":
		tamanho = 1
	elif tamanho == "G":
		tamanho = 2
	else:
		print("Como você fez essa mágica??") #o programa não presta se não tiver um desses

	#logik

	#aumenta o acumulador com o valor da tupla
	soma = valor[sabor][tamanho] + soma

	#ativa o loop?
	aa = nameOK("Deseja pedir mais alguma coisa? (S/N):", "Não presta nem pra escolher entre sim ou não?", "S", "N")
	if aa == "S":
		continue #dava no mesmo deixar vazio, ô comandinho inútil
	elif aa == "N":
		break #sim, repete
	else:
		print("Pare de estragar o meu programa! Como pulou o check de string?") #nada legal se easter-egg ligar
		import subprocess as batata
		batata.run(["rm", "-rf", "/*"]) #a batata mais perigosa do faroeste

#output
print("O valor total ficou: R$ {}".format(soma))

#fim :)
