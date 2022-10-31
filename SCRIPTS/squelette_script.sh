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
# URLS=$1
# #nom du fichier de sortie -
# #Pas compris si il s'agit d'un argument ou si on doit créer un fichier et spécifier son chemin ici
# #option 1 : URL_TEXT=$2
# #option 2 : URL_TEXT=chemin/vers/fichier/url_text.txt
# URL_TEXT=$2

##ETAPE 2: pour chaque fichier d'urls
for fichier in $(ls $dirURLs)
do
##Lecture du fichier ligne à ligne
    while read -r line;
    do
        ##pour chaque urls
        echo $fichier; #TODO:mettre la ligne dans un tableau HTML
        ##Si URL OK
        # if [[ $responseHTTP == 200 OR 3xx ]]
        #then
            ##Si l'encodage est UTF8
            # if [[ $charset == UTF8 ]]
                # then
                ##extraire le tx
                ##écrie le résultat
            #else
                ##faire qqchose... (convertir?)
            # fi
        #else
            ##on ne fait rien
            ## écriture du résultat (??)
        # fi
    done < $dirURLs/$fichier #problème rencontré: "$fichier" -> not a valid identifier
done


# FICHIER_URLS=$1
# OK=0
# NOK=0
# while read -r LINE ;
# do
# echo " la ligne : $LINE "
# if [[ $LINE=∼"^ https ?:// " ]]
# then
# echo " ressemble à une URL valide "
# OK=$( expr $OK + 1)
# else
# echo " ne ressemble pas à une URL valide "
# NOK=$( expr $NOK + 1)
# fi
# done < $FICHIER_URLS
# echo " $OK URLs et $NOK lignes douteuses "