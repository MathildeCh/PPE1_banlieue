##Problèmes rencontrés lors des exercices

#Lire les lignes d’un fichier en bash (exo diapo 22)

3. Comment écrire un tableau d’URL en HTML dans le fichier de sortie ?

On a eu du mal à couper le tableau pour créer 50 fois la row des urls et non 50 fois le tableau en entier -> pb de mise en page

4. Comment y rajouter le numéro de ligne pour chaque URL ?

Pareil, pb pr trouver où mettre la colonne, à la bonne place. #TODO : ajouter CSS pour rendre le tableau plus joli.

#Transformer le script pour lire un dossier

Problème dans la consigne : "Toujours en gardant deux paramètres pour votre script" -> pourquoi garder 2 paramètres ?

1. Comment lire non pas un fichier, mais un dossier d’URL ?

problème rencontré dans terminal: "$fichier" -> not a valid identifier
solution : $dirURLs/$fichier et non seulement $fichier (problème de chemin)

2. Comment séparer les résultats dans un dossier de sortie par langue ?

Problème : comment enlever l'extension de la variable paramètre $fichier (par ex : $fichier=urls_en.txt -> on veux urls_en) ?  #TODO

##Écrire les urls dans un tableau en créant un fichier différent pour chaque langue

Problème : la dernière URL n'était pas prise en compte.
Solution : modifier le fichier .txt des urls et ajouter un espace à la fin de la dernière URL.


