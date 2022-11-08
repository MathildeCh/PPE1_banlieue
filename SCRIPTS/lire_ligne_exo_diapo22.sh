#!/usr/bin/bash

##Sortir du script si pas d'arguments donnés
if [ -z $1 ]
then
    echo "No parameter passed."
    exit
fi

#1. Pourquoi ne pas utiliser cat ?

#Lilas?

#2. Comment transformer "urls.txt" en paramètre ?

#On donne l'url.txt en 1er paramètre, qu'on récupère dans une variable

URLS=$1

# while read -r line;
# do
#     echo $line;
# done < $URLS;

#3. Comment écrire un tableau d’URL en HTML dans le fichier de sortie ?
#3.1 Le HTML devra être encodé en UTF-8 et le mentionner dans l’entête.


# echo "
#     <html>
#         <head>
#             <meta charset="UTF-8" />
#             <title>TABLEAU URLS</title>
#         </head>
#         <body>
#             <table border="1px solid" width="100%">
#                 <thead>
#                     <tr>
#                         <th colspan="2">URLS de $URLS</th>
#                     </tr>
#                 </thead>
#                 <tbody>" > tableau.html;

# while read -r line;
# do
#     echo "
#                     <tr>
#                         <td>$line</td>
#                     </tr>" >> tableau.html;
# done < $URLS;

# echo "          </tbody>
#             </table>
#         </body>
#     </html>" >> tableau.html;


#4. Comment y rajouter le numéro de ligne pour chaque URL ?

i=0

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
                    <th>URLS</th>
                </tr>" > tableau.html;

while read -r line;
do
    i=$(expr $i + 1)
    echo "
                <tr>
                    <td>$i</td>
                    <td>$line</td>
                </tr>" >> tableau.html;
done < $URLS;

echo "
            </table>
        </body>
    </html>" >> tableau.html;
