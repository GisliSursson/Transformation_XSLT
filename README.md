# Devoir de transformation XSLT

Devoir réalisé dans le cadre du cours d'XSLT de Mme Pinche à l'Ecole nationale des chartes (année universitaire 2020-2021).

Proposition d'une feuille de style XSLT pour la transformation d'un [fichier XML-TEI](https://github.com/GisliSursson/Devoir_encodage_XML_TEI) afin de produire une visualisation HTML des données. 

## Consignes

Proposer une feuille XSL pour transformer un encodage XML-TEI en une représentation HTML. 

- Mettre en place une structure d’accueil LaTeX ou HTML (/5) ;
- Rédiger des règles simples avec un Xpath valide pour insérer des informations du document source dans le document de sortie (/4) ;
- Créer une ou des règles avec des conditions (/4) ;
- Utiliser une ou des règles avec for-each uniquement si cela est nécessaire (/3) ;
- Proposer un code facile à lire et commenté (/2) ;
- Simplifier le plus possible ses règles XSL (/2).

# Eléments de la représentation HTML

- Une page d'accueil présentant un index général des pages
- Une page d'introduction reprenant les éléments de l'introduction de l'ODD TEI.
- Un index des personages
- Un index des lieux présentant lorsque c'est possible un lien vers *Google Maps*
- Une visualisation de l'encodage du texte qui comporte :
    - Une couleur par personnage
    - La visualisation des mentions des personages (soulignés)
    - Une numérotation des apparitions de chaque personnage
    - Des liens vers l'index des personages ou des lieux
    - Une visualisation des notes, de l'auteur ou de l'éditeur, au survol de la souris
    - Une légende explicative
