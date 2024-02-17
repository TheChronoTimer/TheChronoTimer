lista = []
id_global = 0

#novo livro
def novo(id):
    nome = input("Digite o nome do livro: ")
    autor = input("Digite o autor do livro: ")
    editora = input("Digite a editora do livro: ")

    livro = {
        "ID": id,
        "Nome": nome,
        "Autor": autor,
        "Editora": editora
    }

    lista.append(livro)

#ver livros
def ler():
    while True: #menu 2
        print("Opções:")
        print("1. Consultar Todos")
        print("2. Consultar por Id")
        print("3. Consultar por Autor")
        print("4. Retornar ao menu")

        opcao = input("Escolha uma opção: ")

		#seletor do menu
        if opcao == "1":
            print("Lista de todos os livros:")
            for livro in lista:
                print(livro)
        elif opcao == "2":
            busca = int(input("Digite o ID do livro que deseja consultar: "))
            for livro in lista:
                if livro["ID"] == busca: #consulta por ID
                    print("Livro encontrado:")
                    print(livro)
                    break
            else:
                print("Livro não encontrado.")
        elif opcao == "3":
            busca = input("Digite o nome do autor que deseja consultar: ")
            print("Livros do autor:")
            for livro in lista:
                if livro["Autor"] == busca:
                    print(livro)
        elif opcao == "4":
            break
        else:
            print("Opção inválida!")

#deletar um livro
def apagar():
    deleta = int(input("Digite o ID do livro que deseja remover: "))
    for livro in lista:
        if livro["ID"] == deleta:
            lista.remove(livro)
            print("Livro removido com sucesso.")
            break
    else:
        print("Livro não encontrado.")

#oi
print("\nBem-vindo ao Gerenciador de Livros do Nicolas Bauermann!")

while True: #menu 1
    print("\nOpções:")
    print("1. Cadastrar Livro")
    print("2. Consultar Livro")
    print("3. Remover Livro")
    print("4. Encerrar Programa")

    opcao = input("\nEscolha uma opção: ")

	#seletor do menu
    if opcao == "1":
        id_global += 1
        novo(id_global)
    elif opcao == "2":
        ler()
    elif opcao == "3":
        apagar()
    elif opcao == "4":
        print("\nPrograma encerrado") #adios
        break
    else:
        print("Opção inválida!")

#fim
