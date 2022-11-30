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
                    <th>N°</th>
                    <th>URLS $fichier</th>
                    <th>code HTTP</th>
                    <th>charset</th>
                    <th>n_occurrence_mot</th>
                    <th>fichier dump</th>
                </tr>" > ./TABLEAUX/tableau_$fichier.html;

                # Ici faut mettre chacun le parcours vers le dossier TABLEAUX dans locale

    ##Lecture du fichier ligne à ligne
    while read -r line;
    do
        occurences_mot=$NONE
        compteur=$(($compteur+1))
        codeHTTP=$(curl -s -L -w '%{http_code}\n' -o $dirURLs/../ASPIRATIONS/ciao$compteur$fichier.html $line)
        encodage=$(curl -Is -L -w '%{content_type}\n' $line | grep -i -P -o "charset=\S+" | cut -d= -f2 | head -n1)



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
<<<<<<< HEAD
                unset occurences_mot 
                occurences_mot=$(lynx -dump -nolist $line | egrep -o -c "\b(suburbs?|periferi(a|e)|banlieues?|προ(ά|α)στ.+)\b")
                lynx -dump -nolist $line > $dirURLs/../DUMPS-TEXT/ciao$compteur$fichier.txt
            fi 
=======
                unset occurences_mot
                occurences_mot=$(lynx -dump -nolist $line | egrep -o -c "\b(suburbs?|periferi(a|e)|banlieues?)\b")
                lynx -dump -nolist $line > ./DUMPS-TEXT/ciao$compteur$fichier.txt
            fi
>>>>>>> c9ca564 (ajout des liens dump)
        fi

        ##pour chaque urls
        echo "
        <tr>
            <td>$compteur</td>
            <td>$line</td>
            <td>$codeHTTP</td>
            <td>$encodage</td>
            <td>$occurences_mot</td>
            <td><a href="../DUMPS-TEXT/ciao$compteur$fichier.txt">text</a></td>
        </tr>" >> ./TABLEAUX/tableau_$fichier.html;
    done < $dirURLs/$fichier;

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
