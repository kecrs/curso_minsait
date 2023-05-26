
#!/bin/bash

curl "https://api.github.com/repos/caiuafranca/dados_curso/contents/"|jq -r '.[].name' > ../../../files_list

cat ../../../files_list | while read line
do
    nome="$(cut -d'.' -f 1 <<< $line)"
    echo $nome
    url_line="${nome%$cr}"
    if [ $(cut -d'.' -f 2 <<< $line) == "csv" ] 
    then
        mkdir $nome
        cd "$nome"
        curl -O "https://raw.githubusercontent.com/caiuafranca/dados_curso/main/$url_line.csv"
        cd ../
    fi
done