# pjulia-packages
Il s'agit d'un petit dépôt de packages pour le langage `petit-julia` dans le cadre du projet de compilation de 2020 à l'ENS ([dépôt de notre compilateur](https://github.com/Sup3Legacy/Petit-Julia-2020)).

Les packages sont simplement des fichiers nommés sous la forme `nom_package.jl`. Leurs informations (nom, description, version, dépendances ainsi que leur lien URL) sont stockés dans le fichier `index.json`. Il s'agit du fichier téléchargé lors de l'appel de la commande `#update` dans notre `REPL`. Une fois ce fichier téléchargé, il est possible d'installer des packages via la commande `#install nom_package`.

Ce dépôt peut être directement cloné mais est destiné à être utilisé par notre gestionnaire de packages custom, `pPkg`, qui est inclu dans notre compilateur (cf. le dépôt du projet pour plus d'informations sur `pPkg`).

Les quelques packages disponibles sont :

* `acker` : implémentation de la fonction d'Ackerman
* `list` : implémentation d'une structure de liste (utilisable avec du sucre syntaxique; cf. le rapport du projet)
* `arithlib` : quelques fonctions arithmétiques utiles
