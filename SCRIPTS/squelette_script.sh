#!/usr/bin/bash

##Sortir du script si pas d'arguments donnés
if [ -z $1 ]
then
    echo "No parameter passed."
    exit
fi

##ETAPE 1: lecture
##fichiers de donnees en entree (FICHIER OU DOSSIER??)
dirURLs=$1
# #nom du fichier de sortie -
# #Pas compris si il s'agit d'un argument ou si on doit créer un fichier et spécifier son chemin ici, et pourquoi?
# #option 1 : URL_TEXT=$2
# #option 2 : URL_TEXT=chemin/vers/fichier/url_text.txt
# URL_TEXT=$2

##ETAPE 2: pour chaque fichier d'urls
for fichier in $(ls $dirURLs)
do
    compteur=0
    echo "
    <html>
        <head>
            <meta charset="UTF-8" />
            <title>TABLEAU URLS</title>
        </head>
        <body>
            <table border="solid" width="100%">
                <tr>
                    <th>N°</th>
                    <th>URLS $fichier</th>
                    <th>code HTTP</th>
                    <th>charset</th>
                </tr>" > tableau_$fichier.html;

    ##Lecture du fichier ligne à ligne
    while read -r line;
    do
        compteur=$(expr $i + 1)
        codeHTTP=$(curl -s -L -w '%{http_code}\n' -o ciao.html $line)
        encodage=$(curl -Is -L -w '%{content_type}\n' $line | grep -i -P -o "charset=\S+" | cut -d= -f2 | head -n1)
        ##pour chaque urls
        echo "
        <tr>
            <td>$i</td>
            <td>$line</td>
            <td>$codeHTTP</td>
            <td>$encodage</td>
        </tr>" >> tableau_$fichier.html;
    done < $dirURLs/$fichier;

    echo "
            </table>
        </body>
    </html>" >> tableau_$fichier.html;

        ##Si URL OK #TODO
        # if [[ $responseHTTP == 200 OR 3xx ]]
        #then
            ##Si l'encodage est UTF8
            # if [[ $encodage == UTF8 ]]
                # then
                ##extraire le tx
                ##écrie le résultat dans tableau
            #else
                ##faire qqchose... (convertir?)
            # fi
        #else
            ##on ne fait rien
            ## écriture du résultat (??)
        # fi
done