#!/bin/bash

# Esse script realizada a verificação de GPG Key existente onde o mesmo é utilizado para assinar os commits do git. Caso não exista, o script irá gerar uma nova GPG Key, e irá exibir a chave pública para que seja adicionada ao GitHub.

# Verifica se existe uma GPG Key
if [ ! -f ~/.gnupg/secring.gpg ]; then
    echo "GPG Key não encontrada, gerando uma nova GPG Key..."
    gpg --full-generate-key
    echo "GPG Key gerada com sucesso!"
    echo "Copie a chave abaixo e adicione ao GitHub:"
    gpg --armor --export $(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | cut -d'/' -f2)
else
    echo "GPG Key encontrada!"
fi


# Configurando o agent do GPG para que o mesmo não solicite a senha a cada commit e push realizado. O script também adiciona a chave privada ao agent do GPG. Para que o script funcione corretamente, é necessário que o mesmo seja adicionado ao arquivo ~/.bashrc ou ~/.zshrc.

# Verifica se o agent do GPG está rodando
if ! pgrep -x "gpg-agent" > /dev/null; then
    echo "Iniciando o agent do GPG..."
    eval $(gpg-agent --daemon)
    echo "Agent do GPG iniciado com sucesso!"
else
    echo "Agent do GPG já está rodando!"
fi

# Adiciona a chave privada ao agent do GPG
echo "Adicionando a chave privada ao agent do GPG..."
gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | cut -d'/' -f2 | xargs gpg --armor --export-secret-keys | gpg --import
echo "Chave privada adicionada com sucesso!"

# Configura o agent do GPG para que o mesmo não solicite a senha a cada commit e push realizado
echo "Configurando o agent do GPG para que o mesmo não solicite a senha a cada commit e push realizado..."
echo "pinentry-program /usr/bin/pinentry-curses" >> ~/.gnupg/gpg-agent.conf
echo "Configuração realizada com sucesso!"

# Reinicia o agent do GPG
echo "Reiniciando o agent do GPG..."
gpgconf --kill gpg-agent
echo "Agent do GPG reiniciado com sucesso!"

# Agora o script irá coletar a chave pública e privada do GPG Key e irá adicionar ao arquivo ~/.gitconfig. Para que o script funcione corretamente, é necessário que o mesmo seja adicionado ao arquivo ~/.bashrc ou ~/.zshrc. E também o mesmo irá configurar o git para que o mesmo assine os commits automaticamente. O script também ira enviar as configurações para o github para que o mesmo reconheça a chave pública.

# Coleta a chave pública e privada do GPG Key
echo "Coletando a chave pública e privada do GPG Key..."
gpg --armor --export $(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | cut -d'/' -f2) > ~/gpgkey.txt

# Adiciona a chave pública e privada do GPG Key ao arquivo ~/.gitconfig
echo "Adicionando a chave pública e privada do GPG Key ao arquivo ~/.gitconfig..."
git config --global user.signingkey $(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | cut -d'/' -f2)
git config --global commit.gpgsign true
git config --global gpg.program gpg
git config --global user.email "ricardoslima2009@hotmail.com"
git config --global user.name "Ricardo Lima"
echo "Chave pública e privada do GPG Key adicionada com sucesso!"

# Envia as configurações para o github para que o mesmo reconheça a chave pública
echo "Enviando as configurações para o github para que o mesmo reconheça a chave pública..."
curl -u "ricardoslima2009" --data "{\"title\":\"$(hostname)\",\"key\":\"$(cat ~/gpgkey.txt)\"}" https://api.github.com/user/gpg_keys
echo "Configurações enviadas com sucesso!"

# Remove o arquivo ~/gpgkey.txt
echo "Removendo o arquivo ~/gpgkey.txt..."
rm -rf ~/gpgkey.txt
echo "Arquivo ~/gpgkey.txt removido com sucesso!"

# Reinicia o agente do GPG
echo "Reiniciando o agent do GPG..."
gpgconf --kill gpg-agent
echo "Agent do GPG reiniciado com sucesso!"

# Reinicia o agente do SSH
echo "Reiniciando o agent do SSH..."
eval $(ssh-agent -s)
echo "Agent do SSH reiniciado com sucesso!"

# Validar se a chave foi adicionada ao GitHub com sucesso e se o mesmo está assinando os commits automaticamente com a chave privada do GPG Key, execute o comando abaixo:
git log --show-signature

