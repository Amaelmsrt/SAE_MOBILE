<center><h1>SAE 4.04 : Développement Mobile All'O 2024</h1></center>

# Equipe du projet

**Etudiant 1** : Amaël Masérati
**Etudiant 2** : Sébastien Gratade

# Les technologies utilisées

## Supabase

Pour ce projet, nous avons répondu aux contraintes qui nous étaient imposées dans le sujet. Tout d'abord, nous avons utilisé Supabase pour la base de données principale. Nous avons des tables pour les utilisateurs, pour les avis, les messages, les annonces, les réponses aux annonces, les catégories, les catégorisations d'objets et d'annonces, et une table pour les images d'une annonce car une annonce peut avoir jusqu'à 4 images.
Nous avons également utilisé le service d'authentification de Supabase afin de gérer les utilisateurs de l'application. Nous avons donc pu gérer les inscriptions, les connexions, les déconnexions, les mises à jour de mot de passe, etc. Nous avons également pu gérer les tokens de sessions pour garder en mémorisation les sessions des utilisateurs et éviter de les déconnecter à chaque fois qu'ils quittent l'application.

## SQFLite

Nous avons utilisé SQFLite pour stocker les données en local. Dans ce cas, la table utilisateur n'était pas nécessaire, nous n'avons gardé que les tables pour les annonces, les objets et leurs catégories respectives. Toutes ces informations nous ont permis de gérer un système de brouillon lorsqu'on crée une annonce ou un objet, sur demande de l'utilisateur, on a le choix de sauvegarder les données en local pour les recharger plus tard. 

# Demonstrations vidéo:


https://github.com/Amaelmsrt/SAE_MOBILE/assets/96087993/4f152105-5129-4cdc-a756-b4e83061e4cc


https://github.com/Amaelmsrt/SAE_MOBILE/assets/96087993/34eb6c68-cac3-42ac-86d7-ce27bad0e840


https://github.com/Amaelmsrt/SAE_MOBILE/assets/96087993/b670bdfd-ec12-40ce-9bc8-2b5d7af19678


https://github.com/Amaelmsrt/SAE_MOBILE/assets/96087993/a2e09a50-2bcc-424f-bf60-4a2ead88d9aa


https://github.com/Amaelmsrt/SAE_MOBILE/assets/96087993/df6a343b-a28d-432e-8b29-d9651fc48ed2


https://github.com/Amaelmsrt/SAE_MOBILE/assets/96087993/7878e165-3917-495e-8b86-72c167baf50e


https://github.com/Amaelmsrt/SAE_MOBILE/assets/96087993/5cea1143-b68b-418b-9c20-2d68ca9585ae


https://github.com/Amaelmsrt/SAE_MOBILE/assets/96087993/8fe30228-0228-4d41-a033-10be218a1b79


# Les différentes pages et fonctionnalités du projet

## Les composants

Nous avons créé de nombreux composants pour la partie Front-End du projet, nous permettant d'exploiter des éléments de Flutter en y ajoutant plus de style et de les réutiliser sans devoir les effectuer de nouveau à chaque fois. Nous avons par exemple les textfields customisés ou encore les snackbar customisés. Par ailleurs, ils nous sont modulables au maximum pour pouvoir les adapter à chaque situation, comme par exemple les textfields qui peuvent être de différentes tailles, avec ou sans icône, avec ou sans bordure, etc. Nous avons également pu optimiser nos composants en leur donnant des constructeurs spécifiques, par exemple pour vue_message, on avait forDefault, forAide et forAvis (pour les messages dans la messagerie ce qui les rendait plus modulables). L'utilisation de composants a grandement accéléré le processus de développement du front-end, en effet, une fois ceux-ci créés nous n'avions plus qu'à les réutiliser et eventuellement leur apporter de legères modifications.

## La page du lancement de l'application

La première fois que nous lançons l'application ou lorsque nous ne sommes pas connectés, nous arrivons sur une page présentant deux boutons : inscription et connexion. Ces dernières nous redirigent vers les pages correspondantes.

## La page d'inscription et de connexion

Dans ces pages, nous avons la possibilité de renseigner un nom d'utilisateur, une adresse mail et une mot de passe, accompagnés de messages d'erreurs si besoin pour obtenir une meilleure compréhension des problèmes si des champs ne sont pas valides.

## La page d'accueil

Après s'être authentifié ou lorsque nous nous connectons sur l'applicaation en étant déjà connecté, nous arrivons sur la page d'accueil. Cette dernière présente les annonces de l'application sous 3 formes différentes : les annonces correspondant aux objets que nous possedons, les annonces les plus récentes et les annonces urgentes, ayant donc un statut **Urgente**. Nous avons également une barre de recherche tout en haut de la page pour rechercher des annonces quelconques. Les annonces sont donc affichées à partir d'une de leurs images, leur titre, leur statut si elles sont urgentes et leur prix. Celles-ci sont donc cliquables, et nous amènent sur la page de l'annonce correspondante.

## La page de l'annonce

Sur la page d'une annonce, nous pouvons apercevoir toutes les informations présentes sur la page d'accueil, avec en plus l'utilisateur qui a créé l'annonce, la description de celle-ci, sa date de publication, la date à laquelle elle doit être achevée et ses catégories. Ensuite, plusieurs possibilités s'offrent à nous. Tout d'abord, un bouton "enregistrer" permettant d'ajouter une annonce à nos favoris. Ensuite, un bouton "contacter" permettant d'envoyer un message à l'utilisateur, commençant ainsi une conversation privée. Pour finir, un bouton "Aider" permet de venir en aide à ce dernier, nous redirigeant donc sur une autre page.

## La page d'aide

Sur cette page, nous devons tout d'abord choisir l'objet que nous souhaitons prêter à l'utilisateur. Par la même occasion, nous pouvons y ajouter un commentaire pour plus de détails. Pour valider notre aide, nous devons appuyer sur le bouton "Aider". Une fois l'aide validée, un message est envoyé à l'utilisateur, et une notification est envoyée à l'utilisateur ayant créé l'annonce, lui indiquant qu'une personne est prête à l'aider, et il peut alors accepter ou refuser celle-ci. Après acceptation, notre objet est considéré comme réservé, et nous ne pouvons plus le prêter à quelqu'un d'autre.

## La page des favoris

Cette page nous permet de voir toutes les annonces que nous avons enregistrées en tant que favoris. Nous pouvons donc les consulter, les supprimer de nos favoris, ou encore les contacter pour venir en aide à l'utilisateur. Une barre de recherche est également présente pour rechercher des annonces spécifiques.

## La page d'ajout d'une annonce

Sur cette page, nous avons de nombreuses informations à renseigner pour créer l'annonce. Tout d'abord, nous pouvons insérer jusqu'à 4 images lui correspondant. Ensuite, nous y entrons son titre, sa description, et choisissons ses catégories. Un système de faciliation de choix de catégories a été effectué, proposant directement à l'annonce les catégories de l'annonce par rapport à ce qu'il a écrit dans le titre ou la description. Nous avons aussi la possibilité d'en choisir d'autres accompagné d'un système de recherche. Nous renseignons ensuite la date de fin de l'annonce, nous avons un bouton pour la rendre urgente, et enfin nous rentrons le prix de l'annonce, qui correspond à la rémunération que nous pouvons effectuer aurpès de l'utilisateur qui nous aide. Pour finir, nous pouvons cliquer sur le bouton d'ajouter d'une annonce, qui va donc soit nous afficher des messages d'erreurs si nous n'avons pas mis d'images ou si nous n'avons pas entré le titre, ou alors nous aurons une popup nous confirmant qu'elle a bien été ajoutée, et nous redirigeant vers la page d'accueil. Si nous décidons de quitter la page, nous avons une popup nous demandant si nous voulons sauvegarder notre annonce en brouillon ou non.

## La page de notifications

Cette page présente deux parties. Premièrement, nous avons l'onglet "Général" qui va nous informer sur les utilisateurs qui ont enregistré nos annonces en tant que favoris, et les utilisateurs qui nous font une demande de location. Le deuxième onglet est "Messages" et va nous permettre d'accéder à toutes nos conversations privées.

## La page de profil

Cette page présente de nombreux éléments. Tout d'abord, nous avons la possibilité d'accéder à une page de modification de profil. Ensuite, nous avons la page "Mes annonces" possédant un onglet avec toutes nos annonces, un avec celles qui sont en cours et un avec celles qui sont cloturées. Lorsqu'une annonce est en cours, on peut la modifier et quand elle est cloturée, on peut laisser un avis sur l'utilisateur que nous avons aidé. Nous avons également la page "Mes objets" listant donc dans un onglet tous nos objets, dans un autre ceux qui sont réservés et dans un dernier ceux qui sont disponibles. Un bouton d'ajout d'objet est aussi présent. Pour les objets non réservés, nous avons un bouton "Aider quelqu'un" qui lorsque nous cliquons dessus, les annonces correspondant à cet objet nous seront proposées. Nous avons aussi une page "Mes avis" qui nous permet de voir les avis que nous avons reçus d'autres utilisateurs. Des avis peuvent être données lorsqu'une annonce a été cloturée avec un système de notation. Enfin, nous avons un bouton de déconnexion.

## La page d'ajouts d'objets

Cette page nous permet d'insérer une image, un titre, une description et des catégories dans le même principe que celle d'ajout d'annonces avec les propositions de catégories, le système de popup, les brouillons, etc.

