#!/usr/bin/env zsh
(
#---------------------------------------------------------------------------------------------------------------------
USUARIO_LOGADO=$( who | egrep console | awk '{print $1}' | egrep "(^[a-zA-Z]{1}[0-9]{6}$)|(^[a-zA-Z]*\.[a-zA-Z]{1}[0-9]{3,4}$)" )
#---------------------------------------------------------------------------------------------------------------------
su - $USUARIO_LOGADO << "EOF"
PATH="$PATH:/Users/$(whoami)/.brew/bin"
#---------------------------------------------------------------------------------------------------------------------
add_to_file_if_needed() {
    if [ ! -f $2 ] || ! fgrep -xq "$1" $2; then
        if [ $# == 3 ]; then
            echo "# $3" >> $2
        fi

        echo $1 >> $2
    fi 
}
#---------------------------------------------------------------------------------------------------------------------
if [ ! -d "/Users/$(whoami)/.brew" ]; then
    Exibicao="Favor instalar o HomeBrew dentro do Hub antes de iniciar a instalação do ASDF e após a instalação do HomeBrew reinstale o ASDF dentro do Hub."
    osascript -e 'display dialog "'"$Exibicao"'" buttons {"OK"}'
    exit 1
fi
#---------------------------------------------------------------------------------------------------------------------
echo "\n🛠️. Verificando JQ...\n"
if [ $(brew list | grep jq) "==" "jq" ]; then
    echo "✅ JQ Encontrado! ✅"
else
    echo "❌ JQ Não encontrado ❌"
    echo "🛠️. Instalando JQ..."
    brew install jq
fi
#---------------------------------------------------------------------------------------------------------------------
echo "\n🛠️. Verificando ASDF...\n"
if [ $(brew list | grep asdf) "==" "asdf" ]; then
    echo "✅ ASDF Encontrado! ✅"
else
    echo "❌ ASDF Não encontrado  ❌"
    echo "🛠️. Instalando ASDF..."
    brew install asdf
fi

add_to_file_if_needed '. $(brew --prefix asdf)/libexec/asdf.sh' /Users/$(whoami)/.zshrc 'ASDF'
add_to_file_if_needed '. $(brew --prefix asdf)/libexec/asdf.sh' /Users/$(whoami)/.bash_profile 'ASDF'
add_to_file_if_needed '. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash' /Users/$(whoami)/.bash_profile
#---------------------------------------------------------------------------------------------------------------------
EOF
#---------------------------------------------------------------------------------------------------------------------
) 2>&1 | tee -a /tmp/ASDF.log
