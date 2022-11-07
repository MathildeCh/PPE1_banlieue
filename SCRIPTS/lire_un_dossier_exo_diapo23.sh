#!/usr/bin/bash

##Sortir du script si pas d'arguments donnés
if [ -z $1 ]
then
    echo "No parameter passed."
    exit
fi

# 1. Comment lire non pas un fichier, mais un dossier d’URL ?

# dirURLs=$1

# for fichier in $(ls $dirURLs)
# do
#     while read -r line;
#     do
#         echo $fichier;
#     done < $dirURLs/$fichier
# done

# 2. Comment séparer les résultats dans un dossier de sortie par langue ?

dirURLs=$1

for fichier in $(ls $dirURLs)
do
    while read -r line;
    do
        echo $fichier >> tableau_$fichier.txt
    done < $dirURLs/$fichier
done

