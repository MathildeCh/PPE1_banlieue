#!/usr/bin/bash

#Pour chaque langue
for lang in en frc ita gr
#On cherche la liste des contextes correspondants
do 
    liste=$(ls  ../PPE1_banlieue/CONTEXTES/*$lang.txt)
    #On crée le concordancier par langue
    echo "
        <html>
        <head>
            <meta charset="UTF-8" />
            <title>Tableau Concordance $lang</title>
        </head>
        <body>
            <table border="solid" width="100%">
                <tr>
                    <th>Contexte droit</th>
                    <th>Mot</th>
                    <th>Contexte gauche</th>
                </tr>" > ../PPE1_banlieue/CONCORDANCE/Tableau_concordance_$lang.html

    #Pour chaque fichier de la liste 
    for fichier in $liste
        do
            #On cherche les mots correspondants, et on prend les contextes qui précèdent le mot, le mot et les contextes qui les suivent
             contexte1=$(grep -E -T "suburbs?|periferi[ae]|banlieues?|προ[άα]στι[οαω]ν?" $fichier | sed -E 's/(.*)(suburbs?|periferi[ae]|banlieues?|προ[άα]στι[οαω]ν?)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/')
             #On stocke directement le tout dans le tableau
        echo $contexte1 >> ../PPE1_banlieue/CONCORDANCE/Tableau_concordance_$lang.html
        done
       
       #On finit le concordancier par langue
        echo "
            </table>
            </body>
        </html>" >> ../PPE1_banlieue/CONCORDANCE/Tableau_concordance_$lang.html
done