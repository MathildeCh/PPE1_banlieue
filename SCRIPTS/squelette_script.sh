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
                    <th>Occurrences mot</th>
                </tr>" > tableau_$fichier.html;

    ##Lecture du fichier ligne à ligne
    while read -r line;
    do
        occurences_mot=$NONE
        compteur=$(($compteur+1))
        codeHTTP=$(curl -s -L -w '%{http_code}\n' -o ciao.html $line)
        encodage=$(curl -Is -L -w '%{content_type}\n' $line | grep -i -P -o "charset=\S+" | cut -d= -f2 | head -n1)

        # Ici on vérifie si un encodage à était recuperé ou pas. Si non, on suppose un encodage en UTF-8

        if test -z "$encodage"
            then
            unset encodage
            encodage=$(echo UTF-8)
        fi

        # Ici on vérifie si le codeHTTP est valide pour l'extraction et si l'encodage est en UTF-8.
        # Si oui, on compte les occurrences du mot cible et on affiche sur le tableau (manque le mot en grec!!! LILAS?).

        if [[ $codeHTTP == "200" || $codeHTTP == "302" ]]
            then
            if [[ $encodage == "UTF-8" || "uft-8" ]]
                then
                unset occurences_mot 
                occurences_mot=$(lynx -dump -nolist $line | egrep -o -c "\b(suburbs?|periferi(a|e)|banlieues?|περίχωρα)\b")
            fi 
        fi

        ##pour chaque urls
        echo "
        <tr>
            <td>$compteur</td>
            <td>$line</td>
            <td>$codeHTTP</td>
            <td>$encodage</td>
            <td>$occurences_mot</td>
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