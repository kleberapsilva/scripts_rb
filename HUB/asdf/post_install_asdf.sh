#!/usr/bin/env zsh
(
#---------------------------------------------------------------------------------------------------------------------
USUARIO_LOGADO=$( who | egrep console | awk '{print $1}' | egrep "(^[a-zA-Z]{1}[0-9]{6}$)|(^[a-zA-Z]*\.[a-zA-Z]{1}[0-9]{3,4}$)" )
#---------------------------------------------------------------------------------------------------------------------
su - $USUARIO_LOGADO << "EOF"
echo "\n🛠️. Verificando Linguagens Default..."
#---------------------------------------------------------------------------------------------------------------------
echo "\n🛠️. Verificando Ruby...\n"
if asdf list ruby > /dev/null; then 
    echo "✅ Ruby Encontrado! ✅"
else
    echo "❌ Ruby Não encontrado  ❌"
    echo "🛠️. Instalando Ruby no ASDF..."
    asdf plugin add ruby
    asdf install ruby 3.2.2
    asdf global ruby 3.2.2
fi
#---------------------------------------------------------------------------------------------------------------------
echo "\n🛠️. Verificando NodeJS...\n"
if asdf list nodejs > /dev/null; then 
    echo "✅ NodeJS Encontrado! ✅"
else
    echo "❌ NodeJS Não encontrado  ❌"
    echo "🛠️. Instalando NodeJS no ASDF..."
    asdf plugin add nodejs
    asdf install nodejs latest
    asdf global nodejs latest
fi
#---------------------------------------------------------------------------------------------------------------------
echo "\n✅ Instalações concluidas! ✅"
#---------------------------------------------------------------------------------------------------------------------
EOF
#---------------------------------------------------------------------------------------------------------------------
) 2>&1 | tee -a /tmp/ASDF.log
