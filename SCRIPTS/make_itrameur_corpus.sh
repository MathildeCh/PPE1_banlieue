#!/usr/bin/env bash

# ATTENTION ce script doit être lancé depuis la racine du projet
if [[ $# -ne 2 ]]
then
    echo "Deux arguments sont attendus : <dossier> <langue>"
    exit
fi

folder=$1 #DUMPS-TEXT
basename=$2 #la langue : url_frc, url_ita, ...

echo "<lang=\"$basename\">" > "ITRAMEUR/$folder-$basename.txt"

for filepath in $(ls $folder/*$basename.txt)
do
    #filepath == DUMPS-TEXT/fr-1.txt
    #==> pagename = url_frc-1
    pagename=$(basename -s .txt $filepath)

    echo "<page!\"$pagename\">" >> "ITRAMEUR/$folder-$basename.txt"
    # POINT IMP : "./" n'est pas obligatoire.
    # Mettre le chemin entre " " est une bonne habitude, plus safe : interpolation avec le nom des variables
    echo "<text>" >> "ITRAMEUR/$folder-$basename.txt"

    #on récupère les dumps/contexte
    #et on écrit à l'inté de la balise text
    content=$(cat $filepath)
    #ATTENTION ordre important : & en premier
    content=$(echo "$content" | sed 's/&/&amp/g')
    content=$(echo "$content" | sed 's/</&lt/g')
    content=$(echo "$content" | sed 's/</&gt/g')


    #On lemmatise
    content=$(echo "$content" | tr '[:upper:]' '[:lower:]' | sed 's/suburbs/suburb/g')
    content=$(echo "$content" | sed 's/banlieues/banlieue/g')
    content=$(echo "$content" | sed 's/periferie/periferia/g')
    content=$(echo "$content" | sed 's/προάστια/προάστιο/g')
    content=$(echo "$content" | sed 's/ποαστίων/προάστιο/g')
    content=$(echo "$content" | sed 's/προαστίου/προάστιο/g')

    echo "$content" >> "ITRAMEUR/$folder-$basename.txt"

    echo "</text>" >> "ITRAMEUR/$folder-$basename.txt"
    echo "</page> §" >> "ITRAMEUR/$folder-$basename.txt"

done