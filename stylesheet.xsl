<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/> <!-- pour éviter les espaces non voulus -->
    
    <xsl:template match="TEI">
        <xsl:variable name="titre_complet">
            <xsl:value-of select="//fileDesc/titleStmt[1]/title/text()"/>
        </xsl:variable>
        
        <!-- Création de la page d'accueil -->
        <xsl:result-document href="./html/index.html">
            <html lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <meta name="description" content="{$titre_complet}"/>
                    <meta name="keywords" content="Jean Bart, TEI, Eugène Sue"/>
                    <meta name="author" content="Victor Meynaud"/>
                    <title><xsl:value-of select="$titre_complet"/></title>
                </head>
                <body>
                    <h1>Visualisation de l'encodage TEI de "<xsl:value-of select="$titre_complet"/>"</h1>
                    <h2>Sélectionnez où vous voulez naviguer</h2>
                    <ul>
                    <li><a href="intro.html">Introduction</a></li>
                    <li><a href="texte.html">Texte</a></li>
                    <li><a href="perso.html">Liste des personnages</a></li>
                    <li><a href="lieux.html">Liste des noms de lieux</a></li>
                    </ul>
                </body>
                <footer>
                    <div>
                        © 2021 Copyright:
                        <a href="https://github.com/GisliSursson">Victor Meynaud</a>
                    </div>
                </footer>
            </html>
        </xsl:result-document>
        
        <!-- Création de la page listant les lieux -->
        <xsl:result-document href="./html/lieux.html">
            <html lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <meta name="description" content="{//fileDesc/titleStmt/title/text()}"/>
                    <meta name="keywords" content="Jean Bart, TEI, Eugène Sue"/>
                    <meta name="author" content="Victor Meynaud"/>
                    <title>Lieux</title>
                    <style>
                        .head {
                        background-color: #6495ED;
                        }
                    </style>
                </head>
                <body>
                    <h1>Liste des lieux</h1>
                    <!-- La template définissant comment les données seront injectée est définie plus loin -->
                    <xsl:call-template name="lieux_tableau"/>
                </body>
                <footer>
                    <div>
                        <a href="index.html">Retour à l'accueil</a>
                    </div>
                </footer>
            </html>
        </xsl:result-document>
        
        <!-- Création de la page listant les personnages -->
        <xsl:result-document href="./html/perso.html">
            <html lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <meta name="description" content="{//fileDesc/titleStmt/title/text()}"/>
                    <meta name="keywords" content="Jean Bart, TEI, Eugène Sue"/>
                    <meta name="author" content="Victor Meynaud"/>
                    <title>Personnages</title>
                    <style>
                        .head {
                        background-color: #6495ED;
                        }
                    </style>
                </head>
                <body>
                    <h1>Liste des personnages</h1>
                    <!-- La template principale est définie plus loin -->
                    <xsl:call-template name="perso_tableau"/>
                </body>
                <footer>
                    <div>
                        <a href="index.html">Retour à l'accueil</a>
                    </div>
                </footer>
            </html>
            
        </xsl:result-document>
        
        <!-- Création de la page d'explications sur la représentation du texte -->
        <xsl:result-document href="./html/explications.html">
            <html lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <meta name="description" content="{$titre_complet}"/>
                    <meta name="keywords" content="Jean Bart, TEI, Eugène Sue"/>
                    <meta name="author" content="Victor Meynaud"/>
                    <title><xsl:value-of select="$titre_complet"/></title>
                    <style>
                        table, th, td {
                        border: 1px solid black;
                        margin-bottom: 50px;
                        }
                        th {
                        position: center;
                        }
                        
                    </style>
                </head>
                <body>
                    <h1>Légende de la représentation du texte</h1>
                    <table>
                        <tr><td>Mot souligné</td><td>personnage</td></tr>
                        <tr><td>Mot souligné italique</td><td>lieu</td></tr>
                        <tr><td>Mot souligné en pointillé</td><td>note de l'éditeur</td></tr>
                        <tr><td>Note numérotée</td><td>note de l'auteur</td></tr>
                    </table>
                    <p>N.B.: les mots en italique dans le corps du texte sont de l'auteur.</p>
                    <table>
                        <thead>Code couleur des dialogues</thead>
                        <tr><td>Gris</td><td>Jean Bart</td></tr>
                        <tr><td>Rouge</td><td>Catherine Bart</td></tr>
                        <tr><td>Vert</td><td>Jean Bart</td></tr>
                        <tr><td>Jaune</td><td>Sauret</td></tr>
                    </table>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Création de la page présentant l'encodage du texte -->
        <xsl:result-document href="./html/texte.html">
            
            <html lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <meta name="description" content="{//fileDesc/titleStmt/title/text()}"/>
                    <meta name="keywords" content="Jean Bart, TEI, Eugène Sue"/>
                    <meta name="author" content="Victor Meynaud"/>
                    <title>Texte</title>
                    <style>
                        /* Pour que les ancres respectent le code couleur */
                        a { 
                        color: inherit; 
                        } 
                        /* Les lieux seront des ancres en italique */
                        .lieux {
                        font-style: italic;
                        }
                        /* Une ancre par personnage qui parle */
                        .said_cornille_bart {
                        color: grey;                 
                        }
                        .said_catherine_bart {
                        color: red;                 
                        }
                        .said_jean_bart {
                        color: green;                 
                        }
                        .said_jacques_seyrac {
                        color: #B29700;
                        }
                        .ita {
                        font-style:italic;
                        }
                        .dialo .tooltip .tooltiptext {
                        color:black;
                        }
                        .lieux .choice {
                        font-style: italic;
                        }
                        div {
                        display:inline;
                        }
                        body {
                        padding:3%;
                        }
                        /* Le tooltip CSS est une petite bulle qui apparaît lorsque l'utilisateur passe sa souris au-dessus de la balise concernée. Il servira à afficher les définitions du glossaire */
                        .tooltip {
                        position: relative;
                        display: inline-block;
                        border-bottom: 1px dotted black; 
                        }
                        
                        /* Tooltip text */
                        .tooltip .tooltiptext {
                        visibility: hidden;
                        width: 400px;
                        background-color: #6495ED;
                        text-align: center;
                        padding: 5px 0;
                        border-radius: 6px;
                        position: absolute;
                        z-index: 1;
                        color: black;
                        }
              
                        .tooltip:hover .tooltiptext {
                        visibility: visible;
                        }
                    </style>
                    
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
                </head>
                <body>
                    <h1>Visualisation de l'encodage du texte</h1>
                    <!-- La template principale est définie plus loin -->
                    <xsl:call-template name="texte"/>
                    <h4><a target="_blank" href="explications.html">Légende</a></h4>
                </body>
                <footer>
                    <div>
                        <a href="index.html">Retour à l'accueil</a>
                    </div>
                </footer>
            </html>
            
        </xsl:result-document>
        
        <!-- Création de la page présentant l'intro. L'intro est une reprise de la documentation ODD de la TEI -->
        <xsl:result-document href="./html/intro.html">
            <html lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <meta name="description" content="{//fileDesc/titleStmt/title/text()}"/>
                    <meta name="keywords" content="Jean Bart, TEI, Eugène Sue"/>
                    <meta name="author" content="Victor Meynaud"/>
                        <title><xsl:value-of select="$titre_complet"/></title>
                    <style>
                         figure {
                        border: 1px #cccccc solid;
                        padding: 4px;
                        margin: auto;
                        }
                         figcaption {
                         background-color: grey;
                         color: black;
                         font-style: italic;
                         padding: 2px;
                         text-align: center;
                         }
                    </style>
                </head>
                <body>
                    <h1>Introduction : données issues de la documentation ODD-HTML</h1>
                    <figure>
                        <img src="./sue.jpg" class="img-fluid" alt="Responsive image" align="left" width="400" height="550"/>
                        <figcaption>Portrait d'Eugène Sue réalisé en 1835 par François Gabriel Guillaume Lépaulle (source : Wikimédia Commons)</figcaption>
                    </figure>    
                    <h2>L'auteur</h2>
                    <p class="h6">Cf. <a href="https://fr.wikipedia.org/wiki/Eug%C3%A8ne_Sue">Wikipedia</a></p>
                                <div>
                                    <xsl:value-of select="//fileDesc/titleStmt/descendant::author"/> est un auteur français né en <xsl:value-of select="//biblFull//author/date[@type='birth']/text()"/> et mort en <xsl:value-of select="//biblFull//author/date[@type='death']/text()"/>. Après avoir été formé par les institutions militaires de la Restauration, il mena une carrière de médecin de marine durant laquelle il participa aux interventions militaires de la France des Bourbons en Espagne et en Grèce. Politiquement, il s'engage à gauche et est élu député de la IIe République. Il est contraint à l'exil après le coup d'Etat de Louis-Napoléon Bonaparte.
                                    
                                    Ces quelques notions biographiques sont impotantes pour comprendre les choix d'encodage réalisés. Les deux principaux points qui ont guidé l'encodage sont les suivants. Premièrement, Sue a produit un ouvrage pseudo-historique qu'il convient de remettre en contexte avec ses engagements politiques personnels et avec les idées nationales-romantiques qui imprégnaient son époque. Deuxièmement, son ouvrage traite de la marine, sujet qu'il maîtrisait. De plus, la marine du milieu du XIXe siècle était encore quasi-exclusivement une marine à voile, comme celle de l'époque de Mazarin.
                                </div>
                            
                        
                    <h2>L'édition</h2>
                    <p class="h6">Cf. <a href="https://gallica.bnf.fr/ark:/12148/bpt6k6365618w.texteImage">Gallica</a></p>
                                <div>
                                    Cette édition a été publiée par <xsl:value-of select="//fileDesc/publicationStmt/descendant::publisher/text()"/> à <xsl:value-of select="//fileDesc/publicationStmt[1]/descendant::pubPlace/text()"/> en <xsl:value-of select="//fileDesc/publicationStmt[1]/descendant::date/@when"/>. Elle contient des illustrations de <xsl:value-of select="//biblFull/descendant::respStmt//persName/forename/text()"/> <xsl:text> </xsl:text> <xsl:value-of select="//biblFull/descendant::respStmt//persName/surname/text()"/>. L'édition est mise à disposition librement par la <xsl:value-of select="//distributor/text()"/> sous une licence <xsl:value-of select="//licence/text()"/>. L'encodage TEI dont il est donné une représentation HTML ici concerne le livre <xsl:value-of select="//biblScope[@unit='book']/@n"/>, chapitre <xsl:value-of select="//biblScope[@unit='chapter']/@n"/>, pages <xsl:value-of select="//biblScope[@unit='page']/@from"/> à <xsl:value-of select="//biblScope[@unit='page']/@to"/>. 

                    <h2>La visualisation HTML</h2>
                                    
                        <p>Il a été décidé de réaliser une visualisation HTML de l'encodage TEI. Celui-ci a pour but de permettre la lecture
                        du texte, la visualisation des éléments que l'encodage TEI permet de faire ressortir ainsi que la compréhension des éléments de l'apparat critique comme on pourrait les voir dans une édition papier.</p>
                        <p>La visualisation comporte les éléments suivants :</p> 
                        <ul>
                            <li>Coloration des dialogues selon le locuteur.</li>
                            <li>Liens cliquables vers l'index des personnages et des lieux.</li>
                            <li>Visualisation des notes et autres éléments de l'apparat critique au survol de la souris.</li>
                        </ul>
                     <!-- Ce qui se trouve ci-dessous est une reprise de la documentation ODD -->
                    <h2>Remarques scientifiques</h2>
                                    <div>
                                        <h3>
                                            Guide d'encodage d'une édition partielle en XML-TEI de
                                            <i>Jean Bart et Louis XIV : drames maritimes du XVIIe siècle</i>
                                            d'Eugène Sue (1804-1857). <small class="text-muted">Cette édition a été réalisée dans le cadre d'un
                                            devoir de XML-TEI pour le cours d'A. Pinche dans le cadre du Master TNAH de
                                            l'Ecole nationale des chartes.</small>
                                        </h3>
                                        <p class="small">
                                            Cette édition partielle a été encodée en suivant les <hi>guidelines</hi> du
                                            TEI Consortium. Ces principes d'encodage ont pour but de garantir la
                                            pérennité , l'interopérabilité et les possibilités de transformation des
                                            données dans un contexte scientifique. L'encodage proposé est donc
                                            <hi>TEI conformant</hi>.
                                        </p>
                                        <div>
                                            <h3>
                                                Explications des principaux choix d'encodage.
                                            </h3>
                                            
                                            <p>
                                                L'élément majeur de l'encodage de l'oeuvre de Sue a été l'indexation des
                                                noms de personne et de lieu. Par exemple :
                                                <code>
                                                    <person xml:id="louis_xiv">
                                                        <persName>Louis XIV</persName>
                                                        <note>roi de France et de Navarre</note>
                                                        <idno type="Wikidata">https://www.wikidata.org/wiki/Q7742</idno>
                                                    </person>
                                                </code>
                                                Grâce à à l'attribut <code>xml:id</code> et au pointeur <code>ref</code>, la TEI
                                                permet de créer une référence d'autorité dans le <code>TEIheader</code> vers
                                                laquelle chaque occurence du nom de personnage va pointer même si celui-ci
                                                est, par exemple, est un surnom. D'un point de vue scientifique, cet
                                                encodage permet, par exemple, de voir comment Sue imaginait la relation
                                                entre un mari et sa femme au XVIIe siècle. Un utilisateur pourra ainsi
                                                automatique accéder à toutes les expressions utilisées pour faire
                                                référence à un personnage (nom, surnom, nom et qualificatif etc.). Pour
                                                les personnages historiques pour lesquels cela était possible, il a été
                                                choisi d'exprimer un lien vers la notice d'autorité <hi>Wikidata</hi> afin
                                                de lever toute ambiguïté possible pour le lecteur.
                                            </p>
                                            <p>
                                                Pour l'indexation des noms de lieu, étant donnée la localisation
                                                géographique des évènements racontés, un choix de standardisation des
                                                toponymes a été nécessaire, par exemple entre le français et le
                                                néerlandais. Il a été choisi de respecter l'usage officiel contemporain en
                                                Belgique ou en France. Cela ne préjuge aucunement des choix faits par Sue
                                                étant donné qu'à l'époque de publication le français était la seule langue
                                                officielle du Royaume de Belgique.
                                            </p>
                                            <p>
                                                Un choix éditorial fort, repésenté par la balise TEI
                                                <code>
                                                    <choice />
                                                </code>
                                                a dû être réalisé pour quelque chose qui a été interprété comme une erreur
                                                d'impression.
                                            </p>
                                            <p>
                                                L'encodage a été réalisé à partir de l'OCR de l'édition originale mise à
                                                dispistion par Gallica, le portail numérique de la Bibliothèque nationale
                                                de France. Quelques corrections mineures de l'OCR ont été faites
                                                manuellement, par exemple le rajout des points de suspension.
                                            </p>
                                            <p>
                                                Les dialogues, importants dans l'extrait, on été encodés par la balise
                                                classique <code>said</code>. Conformément aux <hi>guidelines</hi>, uniquement
                                                ce qui est strictement du discours direct a été encodé de cette façon.
                                            </p>
                                            <p>
                                                Il a été choisi de réaliser un glossaire en marge de l'édition placé dans
                                                la balise <code>standoff</code>. Il est utilisé pour expliciter des termes qui
                                                pourrait être difficiles à comprendre aujourd'hui, par exemple les termes
                                                de marine. Le glossaire renseigne aussi sur certains mots qui,
                                                probablement choisis spécifiquement par l'auteur dans sa volonté d'écrire
                                                un récit historicisant, pouvaient déjà appraître comme vieillis au milieu
                                                du XIXe siècle. Les balises contenues dans le glossaire ont été choisiées
                                                d'après la section <hi>Dictionaries</hi> des <hi>TEI guidelines</hi>.
                                            </p>
                                            <div>
                                                Pour réaliser le glossaire, nous avons décidé d'utiliser deux
                                                dictionnaires relativement proches dans le temps de l'auteur :
                                                <ul>
                                                    <li>
                                                        <i
                                                            >Dictionnaire de l'Académie française, 1835 (6ème édition).</i
                                                        >
                                                    </li>
                                                    <li>
                                                        Emile Littré,
                                                        <i>Dictionnaire de la langue française</i>, Hachette,
                                                        Paris, 1863.
                                                    </li>
                                                </ul>
                                                Dans le cadre de l'exercie, nous avons décidé que l'attribut
                                                <code>glossaire</code> serait le seul possible pour la balise
                                                <gi>standoff</gi>.
                                            </div>
                                            <p>
                                                Les notes de bas de page, représentées par l'encodage classique des
                                                références recommandé par les <hi>TEI guidelines</hi> sont toutes de
                                                l'auteur lorsqu'elles ont l'attribut <code>resp="auteur"</code>. L'élément
                                                <code>ref</code> avec l'attribut <code>resp="editeur"</code> a été choisi pour
                                                symboliser les notes de l'éditeur. Elles servent de pointeur vers le
                                                glossaire. On différencie ainsi les notes de bas de page de l'auteur et le
                                                lexique qui est le fait de l'éditeur. Grâce à l'encodage TEI, un
                                                utilisateur pourrait faire automatiquement des extractions et ainsi voir les
                                                explications que Sue a voulu donner à son propre travail ou encore le type
                                                de vocabulaire qu'il considérait comme difficile pour ses contemporains ou alors le vocabulaire qui a été expliqué par l'éditeur.
                                                Il en va de même pour les quelques passages en italique encodés via la
                                                balise <codes>highlighted</codes> des <hi>TEI guidelines</hi>.
                                            </p>
                                        </div>
                                    </div>
                                    
                                </div>
                </body>
                <footer>
                    <div>
                        <a href="index.html">Retour à l'accueil</a>
                    </div>
                </footer>
            </html>
        </xsl:result-document>
    </xsl:template>  
   
    <!-- Template servant à insérer le tableau présentant les personnages à partir des infos du TEIHeader -->
    <xsl:template name="perso_tableau" match="TEI//listPerson/person">
        <xsl:for-each select="descendant::person">
            <!-- Chaque personnage a son tableau et son id -->
            <table id="{@xml:id}">
                <tbody>
                    <thead class="head">
                            <tr>
                                <td>nom</td>
                                <td><xsl:value-of select="concat(descendant::persName/forename//text(), ' ', descendant::persName/surname//text())"/></td>
                            </tr>
                    </thead>
                    <!-- Test : le personnage a-t-il un autre nom? Si oui quel est le type de cet autre nom?  -->
                            <xsl:if test="descendant::persName/addName">
                                <xsl:for-each select=".">
                                    <tr>
                                        <td><xsl:value-of select="replace(descendant::persName/addName[1]/@type, '_', ' ')"/></td>
                                        <td><xsl:value-of select="descendant::persName/addName/text()"/></td>
                                    </tr>
                                </xsl:for-each>
                            </xsl:if>
                    
              
                    <!-- On doit ici faire à chaque fois des tests car tous les personnages n'ont pas les mêmes champs renseignés -->
                    <xsl:if test="descendant::date">
                                <tr>
                                    <td>date de naissance</td>
                                    <td><xsl:value-of select="descendant::date[@type='birth']/text()"/></td>
                                </tr>
                                <tr>
                                    <td>date de décès</td>
                                    <td><xsl:value-of select="descendant::date[@type='death']/text()"/></td>
                                </tr>
    
                    </xsl:if>
                    <xsl:if test="descendant::note">
                        <tr>
                            <td>note</td>
                            <td><xsl:value-of select="descendant::note/text()"/></td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="descendant::idno">
                        <tr>
                            <td>référence</td>
                            <td><a href="{descendant::idno/text()}">Wikidata</a></td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Template servant à insérer la liste des lieux dans la page dédiée -->
    <xsl:template name="lieux_tableau" match="TEI//listPlace">
        <xsl:for-each select="descendant::place">
            <table class="table table-bordered" id="{@xml:id}">
                <tbody>
                    <!-- Test : le lieu a-t-il plusieurs noms? -->
                    <xsl:choose>
                        <xsl:when test="count(descendant::placeName)>1">
                            <thead class="head">
                                <tr>
                                    <td>nom</td>
                                    <td><xsl:value-of select="descendant::placeName[1]/text()"/></td>
                                </tr>
                            </thead>
                            <tr>
                                <td>autre nom</td>
                                <td><xsl:value-of select="descendant::placeName[2]/text()"/></td>
                            </tr>
                        </xsl:when>
                        <xsl:otherwise>
                            <thead class="head">
                                <td>nom</td>
                                <td><xsl:value-of select="descendant::placeName/text()"/></td>
                            </thead>
                        </xsl:otherwise>
                   </xsl:choose>
                    <tr>
                        <td>note</td>
                        <td><xsl:value-of select="descendant::note/text()"/></td>
                    </tr>
                    <xsl:variable name="loc">
                        <xsl:value-of select="concat('https://www.google.com/maps/place/', @xml:id)"/>
                    </xsl:variable>
                    <!-- On ne propose une carte que lorsque le lieu existe sur Google Maps -->
                    <xsl:choose>
                        <!-- On ne fait rien lorsque le lieu n'existe pas sur Google Maps -->
                        <xsl:when test="@xml:id='hollande'"/>
                        <xsl:when test="@xml:id='mardyck'"/>
                        <xsl:when test="@xml:id='effarinchouque'"/>
                        <xsl:otherwise>
                            <tr>
                                <td>Localisation</td>
                                <td><a href="{$loc}">Voir carte</a></td>
                            </tr>
                        </xsl:otherwise>
                    </xsl:choose>
                   
                </tbody>
            </table>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Template servant à insérer le texte -->
    <xsl:template name="texte" match="TEI//body">
        
      <h2><xsl:value-of select="descendant::div[1]/head/text()"/></h2>
      <h3><xsl:value-of select="descendant::div[2]/head/text()"/></h3>
      
      <p>[...]</p>
        
      <!-- Ici texte -->
      
      <xsl:element name="p">
          <xsl:apply-templates select="//p[2]"/>
      </xsl:element>
    </xsl:template>
    
    <!-- Chaque personnage sera une ancre renvoyant vers l'entrée correspondante dans l'index des personnages -->
    <xsl:template name="persname" match="TEI//body//p//persName">
        <xsl:variable name="nom_pers">
            <xsl:value-of select="./@ref"/>
        </xsl:variable>
        <xsl:variable name="countPers">
            <xsl:number count="TEI/descendant::text/body//p//persName[@ref=$nom_pers]" level="any"/>
        </xsl:variable>
              <xsl:element name="a">
                  <xsl:attribute name="href">
                      <xsl:text>perso.html</xsl:text><xsl:value-of select="@ref"/>
                  </xsl:attribute>
                  <!-- Chaque personnage a un id composé de son nom et d'un numéro. Le numéro énumère le nombre de fois 
                  où le personnage a été mentionné jusqu'à l'occurence concernée -->
                  <xsl:attribute name="id">
                      <xsl:value-of select="concat(replace(@ref, '#', ''), '_', $countPers)"/>
                  </xsl:attribute>
                  <xsl:attribute name="class">
                      <xsl:text>perso</xsl:text>
                  </xsl:attribute>
                 <!-- Cette syntaxe permet de récupérer tous les descendants : texte et balises --> 
                  <xsl:value-of select="child::node()"/>
              </xsl:element>
          </xsl:template>
    
    <!-- Chaque lieu sera une ancre renvoyant vers l'entrée correspondante dans l'index des lieux -->
    <xsl:template name="placename" match="TEI//body//p//placeName">
        <xsl:variable name="nom_lieu">
            <xsl:value-of select="./@ref"/>
        </xsl:variable>
        <xsl:variable name="countPlace">
            <xsl:number count="TEI/descendant::text/body//p//placeName[@ref=$nom_lieu]" level="any"/>
        </xsl:variable>
              <xsl:element name="a">
                  <xsl:attribute name="href">
                      <xsl:text>lieux.html</xsl:text><xsl:value-of select="@ref"/>
                  </xsl:attribute>
                  <!-- Les id des lieux sont construits de la même façon que les id des personnages -->
                  <xsl:attribute name="id">
                      <xsl:value-of select="concat(replace(@ref, '#', ''), '_', $countPlace)"/>
                  </xsl:attribute>
                  <xsl:attribute name="class">
                      <xsl:text>lieux</xsl:text>
                  </xsl:attribute>
                  <xsl:value-of select="text()"/>
              </xsl:element>
          </xsl:template>
    
    <!-- Tous les passages de dialogue sont présentés dans une couleur différente -->    
    <xsl:template name="said" match="TEI//body//p/said">
              <xsl:element name="span">
                  <xsl:attribute name="class">
                      <xsl:value-of select="concat('said', '_', replace(@who, '#', ''))"/>
                  </xsl:attribute>
                  <xsl:apply-templates/>
              </xsl:element>
          </xsl:template>
    
    <!-- Règle construisant un tableau HTML qui apparaîtra en tooltip pour présenter les données du glossaire 
    au niveau de chaque occurence du mot concerné -->
    <xsl:template name="ref" match="TEI//body//p//ref">
              <xsl:variable name="nom">
                  <xsl:value-of select="replace(@target, '#', '')"/>
              </xsl:variable>
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="$nom"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>tooltip</xsl:text>
            </xsl:attribute>
 
            <xsl:value-of select="child::node()"/>
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>tooltiptext</xsl:text>
                </xsl:attribute>
                <!-- On doit ici utiliser des "for each" car toutes les entrées du lexique n'ont pas les mêmes champs renseignés ou dans le même nombre -->
                <table>
                    <!-- On prévoit le cas où il y aurait plusieurs formes -->
                    <tr><td>Forme(s)</td><td><xsl:for-each select="ancestor::TEI//standOff/entry[@xml:id=$nom]/form//text()"><xsl:choose><xsl:when test="position() != last()"><xsl:value-of select="concat(., ', ')"/></xsl:when><xsl:otherwise><xsl:value-of select="."/></xsl:otherwise></xsl:choose></xsl:for-each></td></tr>
                    <tr><td>Grammaire</td> <td><xsl:for-each select="ancestor::TEI//standOff/entry[@xml:id=$nom]/gramGrp//text()"><xsl:value-of select="concat(., ' ')"/></xsl:for-each></td></tr>
                    <!-- On prévoit le cas où il y aurait plusieurs usages indiqués -->
                    <tr><td>Usage</td><td><xsl:if test="not(ancestor::TEI//standOff/entry[@xml:id=$nom]/usg/text())">n.a.</xsl:if><xsl:for-each select="ancestor::TEI//standOff/entry[@xml:id=$nom]/usg/text()"><xsl:choose><xsl:when test="position() != last()"><xsl:value-of select="concat(., ', ')"/></xsl:when><xsl:otherwise><xsl:value-of select="."/></xsl:otherwise></xsl:choose></xsl:for-each></td></tr>
                    <tr><td>Définition</td><td><xsl:for-each select="ancestor::TEI//standOff/entry[@xml:id=$nom]/def/text()"><xsl:value-of select="."/></xsl:for-each></td></tr>
                    <tr>(note de l'éditeur)</tr>
                </table>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- Règle servant à afficher les notes (de l'auteur) en tooltip -->
    <xsl:template name="note" match="TEI//body//p//note">
        <xsl:variable name="nb_note">
            <xsl:number count="TEI//body//p//note" level="any"/>
        </xsl:variable>
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="text()"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>tooltip</xsl:text>
            </xsl:attribute>

            [<xsl:value-of select="$nb_note"/>]
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>tooltiptext</xsl:text>
                </xsl:attribute>
                <span>Note de l'auteur : <!--  Ici, le texte sera affiché par une règle vide. S'il y a des balises dans les notes,
                elles seront traitées par les règles suivantes-->
                <xsl:apply-templates/></span>
            </xsl:element>
            
        </xsl:element>
        
    </xsl:template>
    
    <!-- Règle pour les passages en italique (dans les notes de l'auteur ou le corps du texte) -->
    <xsl:template name="ita" match="TEI//body//p//hi">
        <span class="ita"><xsl:value-of select="node()"/></span>
    </xsl:template>
    
    <!-- Règle correspondant au "choice" TEI (ici choix de l'éditeur à cause d'une erreur d'impression dans l'orignal) -->
    <xsl:template name="choice" match="TEI//body//p//choice">
        <span class="choice"><xsl:value-of select="descendant::corr/node()"/></span><span class="sic"> [<xsl:value-of select="descendant::sic/node()"/>]</span>
    </xsl:template>

</xsl:stylesheet>