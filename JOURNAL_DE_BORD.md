# JOURNAL DE BORD

## 28/09/2022

### Constitution du groupe et choix des langues

- Diego : *italien* (langue maternelle), *anglais* 
- Mathilde : *français* (langue maternelle), *anglais*

## 29/09/2022

### Critères pour le choix du mot 

- le mot doit être **facilement traduisible** dans toutes les langues
- le mot doit être sémantiquement variable en fonction du **contexte linguistique** 
- le mot doit avoir une **dénotation** ni trop large ni confuse 
Ces trois critères nous permettront de constituer un corpus multilingue comparable et cohérent autour de l'emploi différencié du mot en fonction des contextes socio-linguistiques.

## 30/09/2022

### Première proposition de mot

- Diego : “*sentir*”<br>

**Problèmes** :
1. ne respecte pas le critère de *dénotation* (plus de 10 sens dans l'entrée lexicale en français)
2. aucun verbe ne semble avoir été choisi au cours des années précédentes, peut-être le même problème de dénotation pour beaucoup de verbes : nous ne choisirons pas de verbe

## 03/10/2022

### Deuxième proposition de mot 

- Mathilde : "*dépaysement*”<br>

**Problème** :
1. ne respecte pas le critère de *traduisibilité* 

## 06/10/2022

### Choix du mot définitif

- Diego et Mathilde : "***banlieue***"<br>
Répond aux trois critères


## 10/10/2022 

### Démarche de constitution du corpus

Nous avons décidé de découper le travail en 3 étapes
1. choix des **traductions**
2. recherche de corpus en **contexte** (définition de mots clés liés au mot choisi)
3. **comparaison** et analyse rapide des résultats pour vérifier la cohérence du corpus


## 19/10/2022

### Mise en contexte du mot

Nous avons décidé de constituer un corpus d'*articles de presse* présentant une **coocurrence** des termes "banlieue" et "**police**". Ce choix nous permet d'avoir un corpus plus cohérent en délimitant le contexte linguistique dans lequel le terme "banlieue" est employé.

## 26/10/2022

### Ajout des urls et de Lilas

Ajout des urls en *anglais*, *français* et *italien* : recherche effectuée sur *Google News* avec la coocurrence de "banlieue" et "police".<br>
Notre groupe s'agrandit et une nouvelle langue s'ajoute à la constitution de notre corpus, le *grec moderne*. 

## 30/10/2022

### Ajout des urls grecs

Constitution du corpus sur le même principe de recherche de coocurrence sur *Google News*

## 31/10/2022

### Création du journal de bord

Nous avons retracé le parcours effectué jusqu'à présent.

## 08/11/2022

### Table HTML: intégration du numéro de ligne et des urls.

Nous avons créé le script qui permet de créer les tableaux HTML par corpus avec le numéro de ligne et les urls. Nous avons aussi trouvé comment isoler le code de la réponse HTTP.

## 16/11/2022

### Table HTML: intégration du code HTTP et de l'encodage.

Nous avons inclus le code HTTP aux tableaux. Nous avons également trouvé comment isoler l'encodage (charset) du header et l'inclure dans les tableaux (à finaliser). Nous avons presque réussi à isoler les titres des articles.

## 21/11/2022

### Table HTML: intégration vérification encodage + comptage mot cible (incomplet!)

Nous avons inclus les comptages des occurrences du mot cible dans les différents langues après vérification du codeHTTP correct. Il manque toutefois le comptage du mot grec équivalent à "banlieue". Il reste à vérifier comment traiter les urls qui n'ont pas un codeHTTP valable (403) pour l'extraction du texte.


## 23/11/2022

### Réorganisation de l'arborescence

Nous avons créé les dossiers TABLEAUX et ASPIRATIONS afin de stocker les tableaux et les pages html. Nous avons modifié squelette_script.sh en conséquence. 

### Tentative d'accepter les cookies

Nous avons essayé plusieurs méthodes sur curl (-b --cookie) et lynx (FORCE_SSL_COOKIES_SECURE:TRUE) pour accepter les cookies automatiquement et éviter certains codes HTTP 403, mais sans succès. Nous estimons que nous en avons suffisamment peu pour que ça ne pose pas problème outre mesure. 

### Dossier DUMPS-TEXT

Nous avons créé le dossier DUMPS-TEXT qui contient le texte en intégralité des urls avec un code HTTP 200, extrait avec lynx. 