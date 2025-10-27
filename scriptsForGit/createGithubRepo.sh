#!/bin/bash

# Torna o próprio script executável (caso ainda não seja)
chmod +x "$0"

echo "O script deve ser rodado dentro do diretório que se tornará o repositório no GitHub."

# Pergunta o nome do repositório
read -p "Qual será o nome do repositório? " nome

# Valida o nome do repositório
if [ -z "$nome" ]; then
    echo "Nome inválido. Saindo..."
    exit 1
fi

# Pergunta a visibilidade e valida a entrada
echo -e "Você deseja criar um repositório público ou privado?\n1 - Público\n2 - Privado"
read visibilidade

case "$visibilidade" in
    1)
        tipo="--public"
        ;;
    2)
        tipo="--private"
        ;;
    *)
        echo "Opção inválida. O repositório será público por padrão."
        tipo="--public"
        ;;
esac

# Inicializa Git se ainda não for um repositório
if [ ! -d ".git" ]; then
    echo "Inicializando repositório Git local..."
    git init
    git add .
    git commit -m "Commit inicial"
fi

# Cria o repositório no GitHub
echo "Criando o repositório '$nome' no GitHub..."
gh repo create "$nome" $tipo --source=. --push

# Cria o repositório usando GitHub CLI
echo "Criando o repositório '$nome' no GitHub..."
gh repo create "$nome" $tipo --source=. --push

if [ $? -eq 0 ]; then
    echo "Repositório '$nome' criado com sucesso!"
else
    echo "Ocorreu um erro ao criar o repositório."
fi
