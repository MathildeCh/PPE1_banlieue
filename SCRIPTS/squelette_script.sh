#!/usr/bin/bash

##Sortir du script si pas d'arguments donnés
if [ -z $1 ]
then
    echo "No parameter passed."
    exit
fi

##ETAPE 1: lecture
#fichiers de donnees en entree
dirURLs=$1
#nom du fichier de sortie -
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
                    <th>ligne</th>
                    <th>code HTTP</th>
                    <th>titre</th>
                    <th>URLS $fichier</th>
                    <th>Encodage</th>
                    <th>dump html</th>
                    <th>dump text</th>
                    <th>n_occurrence_mot</th>
                    <th>contexte</th>
                </tr>" > ./TABLEAUX/tableau_$fichier.html;

                # Ici faut mettre chacun le parcours vers le dossier TABLEAUX dans locale

    ##Lecture du fichier ligne à ligne
    while read -r line;
    do
        occurences_mot=$NONE
        contexte=$NONE
        compteur=$(($compteur+1))
        codeHTTP=$(curl -b --cookie -A "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0"  -L -w '%{http_code}\n' -o ./ASPIRATIONS/ciao$compteur$fichier.html $line)
        encodage=$(curl -Is -L -w '%{content_type}\n' ./ASPIRATIONS/ciao$compteur$fichier.html | grep -i -P -o "charset=\S+" | cut -d= -f2 | head -n1)
        xmllint --html --xmlout ./ASPIRATIONS/ciao$compteur$fichier.html > ciao.xhtml
            header=$(grep -m 1 "<title>" ciao.xhtml | cut -d\> -f2 | cut -d\< -f1)
            if [ $header=="" ]
            then
                header=$(xmlstarlet select -T --template  --value-of /html/head/title --nl ciao.xhtml)
            fi


        # Ici on teste si l'encodage est bien en utf-8. Si aucun encodage est relevé on suppose utf-8.
        if test -z "$encodage"
            then
            encodage="UTF-8"
        fi


        # Ici on recupère le texte du URL si le code HTTP le permet
        if [[ $codeHTTP == "200" || $codeHTTP == "302" ]]
            then
            if [[ $encodage == "UTF-8" || "uft-8" ]]
                then
                unset occurences_mot
                lynx -dump -nolist ./ASPIRATIONS/ciao$compteur$fichier.html > ./DUMPS-TEXT/ciao$compteur$fichier.txt
                occurences_mot=$(egrep -o -c "\b(suburbs?|periferi(a|e)|banlieues?|προ(ά|α)στ.+)\b" ./DUMPS-TEXT/ciao$compteur$fichier.txt)
                egrep -B 1 -A 1  "\b(suburbs?|periferi(a|e)|banlieues?|προ(ά|α)στ.+)\b" ./DUMPS-TEXT/ciao$compteur$fichier.txt > ./CONTEXTES/contexte_$compteur$fichier.txt  
                fi         
        fi

        ##pour chaque urls
        echo "
        <tr>
            <td>$compteur</td>
            <td>$codeHTTP</td>
            <td>$header</td>
            <td><a href="$line">$line</a></td>
            <td>$encodage</td>
            <td><a href="../ASPIRATIONS/ciao$compteur$fichier.html">html</a></td>
            <td><a href="../DUMPS-TEXT/ciao$compteur$fichier.txt">text</a></td>
            <td>$occurences_mot</td>
            <td><a href="../CONTEXTES/contexte_$compteur$fichier.txt">contexte</a></td>
        </tr>" >> ./TABLEAUX/tableau_$fichier.html;
    done < ./URLS/$fichier;

    echo "
            </table>
        </body>
    </html>" >> ./TABLEAUX/tableau_$fichier.html;

        ##Si URL OK
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
