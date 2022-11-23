# !/ usr / bin / bash

if [ $# -ne 1 ]
then
	echo " ce programme demande un argument "
	exit
fi


DOSSIER_URLS=$1


for fichier in $(ls $DOSSIER_URLS)
do
	compteur=0
	compteur_tableau=$(($compteur_tableau+1))
	echo "
	<html>
		<head>
			<meta charset = "utf-8"/>
			<title>TABLEAU</title>
		</head>
		<body>
			<table border="6px" border-color="#008080">
				<tr>
					<th>N°</th>
					<th>Titre</th>
					<th>CodeHTTP</th>
					<th>URLS</th>					
				</tr>" > tableau-$compteur_tableau.html
	while read -r line
	do
			compteur=$(($compteur+1))
			CodeHTTP=$(curl -L -w '%{http_code}\n' -o ciao.html "$line")
			xmllint --html --xmlout ciao.html > ciao.xhtml
			header=$(xmlstarlet select -T --template  --value-of /html/head/title --nl ciao.xhtml)
			echo "
				<tr>
					<td>$compteur</td>
					<td>$header</td>
					<td>$CodeHTTP</td>
					<td>$line</td>" >> tableau-$compteur_tableau.html
	done < $DOSSIER_URLS/$fichier
			echo "
				</tr>
			</table>
		</body>
	</html>" >> tableau-$compteur_tableau.html
done 


