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
    echo '
    <!DOCTYPE html>
    <html lang="fr">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Tableaux</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

            <link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
            <link href="../assets/CSS/blog.css" rel="stylesheet">
        </head>
        <body>
            <div class="container mb-4">
                <header class="blog-header lh-1 py-3">
                    <div class="row flex-nowrap justify-content-between align-items-center">
                    <div class="col-6 text-center">
                        <a class="blog-header-logo text-dark" href="./index.html">BANLIEUE</a>
                    </div>
                    <div>
                        <img width="8%" src="../assets/img/banlieue_logo2.png" alt="">
                    </div>
                    </div>
                </header>

                <div class="d-flex justify-content-between align-items-stretch">
                    <nav class="nav navbar navbar-expand-lg">
                        <div class="container-fluid py-1 mb-12">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <strong><a class="nav-link" aria-current="page" href="../index.html">ACCUEIL</a></strong>
                                </li>
                                <li class="nav-item">
                                    <strong><a class="nav-link"href="../etapes.html">ÉTAPES DU PROJET</a></strong>
                                </li>
                                <li class="nav-item">
                                    <strong><a class="nav-link"  href="../TABLEAUX/index.html">TABLEAUX</a></strong>
                                </li>
                                <li class="nav-item">
                                    <strong><a class="nav-link"  href="../scripts.html">SCRIPTS</a></strong>
                                </li>
                                <li class="nav-item">
                                    <strong><a class="nav-link"  href="../resultats.html">ANALYSE DES RÉSULTATS</a></strong>
                                </li>
                                <li class="nav-item">
                                    <strong><a class="nav-link"  href="../contact.html">CONTACT</a></strong>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>

            <main class="container mt-3">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Ligne</th>
                            <th>Code HTTP</th>
                            <th>Titres</th>
                            <th>URLS</th>
                            <th>Encodage</th>
                            <th>Dump html</th>
                            <th>Dump text</th>
                            <th>Nombre occurrences</th>
                            <th>contexte</th>
                            <th>Concordance</th>
                        </tr>
                    </thead>
                    <tbody>' > ./TABLEAUX/tableau_$fichier.html;

    ##Lecture du fichier ligne à ligne
    while read -r line;
    do
        occurences_mot=$NONE
        contexte=$NONE
        compteur=$(($compteur+1))
        codeHTTP=$(curl -b --cookie -A "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0"  -L -w '%{http_code}\n' -o ./ASPIRATIONS/$fichier$compteur.html $line)
        encodage=$(curl -Is -L -w '%{content_type}\n' ./ASPIRATIONS/$fichier$compteur.html | grep -i -P -o "charset=\S+" | cut -d= -f2 | head -n1)
        xmllint --html --xmlout ./ASPIRATIONS/$fichier$compteur.html > ciao.xhtml
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
                lynx -dump -nolist ./ASPIRATIONS/$fichier$compteur.html > ./DUMPS-TEXT/$compteur$fichier
                occurences_mot=$(egrep -o -i -c "\b(suburbs?|periferi(a|e)|banlieues?|προ(ά|α)στ.+)(\b|\n|\')" ./DUMPS-TEXT/$compteur$fichier)
                egrep -i -B 1 -A 1  "\b(suburbs?|periferi(a|e)|banlieues?|προ(ά|α)στ.+)(\b|\n|\')" ./DUMPS-TEXT/$compteur$fichier > ./CONTEXTES/$compteur$fichier
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
                <td><a href="../ASPIRATIONS/$fichier$compteur.html">html</a></td>
                <td><a href="../DUMPS-TEXT/$compteur$fichier">text</a></td>
                <td>$occurences_mot</td>
                <td><a href="../CONTEXTES/$compteur$fichier">contexte</a></td>
                <td><a href="../CONCORDANCE/Tableau_concordance_${fichier%.*}.html">concordance</a></td>
            </tr>" >> ./TABLEAUX/tableau_$fichier.html;
    done < ./URLS/$fichier;

    echo "
                    </tbody>
                </table>

                <nav class="blog-pagination" aria-label="Pagination">
                    <a class="btn btn-outline-warning rounded-pill" href="">Haut</a>
                </nav>
                <div class="container d-flex justify-content-center">
                    <nav class="blog-pagination" aria-label="Pagination">
                        <a class="btn btn-outline-dark rounded-pill" href="../TABLEAUX/tableau_en.txt.html">Tableau anglais</a>
                        <a class="btn btn-outline-dark rounded-pill" href="../TABLEAUX/tableau_fr.txt.html">Tableau français</a>
                        <a class="btn btn-outline-dark rounded-pill" href="../TABLEAUX/tableau_it.txt.html">Tableau italien</a>
                        <a class="btn btn-outline-dark rounded-pill" href="../TABLEAUX/tableau_gr.txt.html">Tableau grec</a>
                    </nav>
                </div>
            </main>
            <footer class="blog-footer">
                <div class="mb-3">
                    <nav class="footer d-flex justify-content-around">
                        <a class="link-secondary" href="../index.html">Accueil</a>
                        <a class="link-secondary" href="../etapes.html">Étapes du projet</a>
                        <a class="link-secondary" href="../TABLEAUX/index.html">Tableaux</a>
                        <a class="link-secondary" href="../scripts.html">Scripts</a>
                        <a class="link-secondary" href="../resultats.html">Résultats</a>
                        <a class="link-secondary" href="../contact.html">Contact</a>
                    </nav>
                </div>
                <p class="mb-0">Made with love by Mathou, Dedo & Lilou</p>
            </footer>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
        </body>
    </html>" >> ./TABLEAUX/tableau_$fichier.html;
done
