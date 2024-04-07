<center><h1>SAE 4.04 : Développement Mobile All'O 2024</h1></center>

# Equipe du projet

**Etudiant 1** : Amaël Masérati
**Etudiant 2** : Sébastien Gratade

# Les technologies utilisées

## Supabase

Pour ce projet, nous avons répondu aux contraintes qui nous étaient imposées dans le sujet. Tout d'abord, nous avons utilisé Supabase pour la base de données principale. Nous avons des tables pour les utilisateurs, pour les avis, les messages, les annonces, les réponses aux annonces, les catégories, les catégorisations d'objets et d'annonces, et une table pour les images d'une annonce car une annonce peut avoir jusqu'à 4 images.

## SQFLite

Nous avons utilisé SQFLite pour stocker les données en local. Dans ce cas, la table utilisateur n'était pas nécessaire, nous n'avons gardé que les tables pour les annonces, les objets et leurs catégories respectives. Toutes ces informations nous ont permis de gérer un système de brouillon lorsqu'on crée une annonce ou un objet, pour garder les informations en local et éviter de les retaper si besoin si nous devons quitter l'application de manière inopinée.

# Les différentes pages et fonctionnalités du projet

## Les composants

Nous avons créé de nombreux composants pour la partie Front-End du projet, nous permettant d'exploiter des éléments de Flutter en y ajoutant plus de style et de les réutiliser sans devoir les effectuer de nouveau à chaque fois. Nous avons par exemple les textfields customisés ou encore les snackbar customisés.

## La page d'accueil

La première fois que nous lançons l'application ou lorsque nous ne sommes pas connectés, nous arrivons sur une page présentant deux boutons : inscription et connexion. Ces dernières nous redirigent vers les pages correspondantes.

## La page d'inscription et de connexion

Dans ces pages, nous avons la possibilité de renseigner un nom d'utilisateur, une adresse mail et une mot de passe, accompagnés de messages d'erreurs si besoin pour obtenir une meilleure compréhension des problèmes si des champs ne sont pas valides.

