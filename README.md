
Développement / Production
==========================

Pour le développement : `docker compose up` utilise `docker-compose.yml` qui cible l'étape `builder` pour avoir le rechargement à chaud.
Pour la production : `docker compose -f docker-compose.prod.yml up --build -d` utilise `docker-compose.prod.yml` qui construit l'image finale optimisée avec Nginx.
Votre projet est maintenant plus propre et suit les meilleures pratiques modernes de Docker. Bravo !

Votre Dockerfile unifié utilise une construction multi-étapes (multi-stage build).

Une première étape (`builder`) installe les dépendances et construit le site Jekyll.
Une seconde étape (l'image `nginx`) copie uniquement le site statique construit pour le servir.
Lorsque vous lancez un build sans spécifier de target (comme c'est le cas pour la production), Docker construit par défaut la toute dernière étape du Dockerfile. C'est exactement ce que nous voulons pour la production : une image Nginx légère avec uniquement les fichiers du site.

The Correct Way to Deploy
==========================


```bash
# 1. Get the latest version of your application code
git pull

# Eventuellement suppression conteneur et image si du contenu statique n'est pas pris en compte (par exemple des images)


# 2. Rebuild the image and restart the service in one command
docker compose -f docker-compose.prod.yml up -d --build


# Alternative "Clean Slate" Workflow
# 1. Get the latest version of your application code
git pull

# 2. Stop and remove the old containers and networks
docker compose -f docker-compose.prod.yml down

# 3. Build the new image and start the service
docker compose -f docker-compose.prod.yml up -d

# Housekeeping: Pruning Old Images
docker image prune
```



Agency Jekyll theme
====================

Agency theme based on [Agency bootstrap theme ](https://startbootstrap.com/template-overviews/agency/)

# How to use

### Portfolio 

Portfolio projects are in '/_posts'

Images are in '/img/portfolio'

### About

Images are in '/img/about/'

### Team

Team members and info are in '_config.yml'

Images are in '/img/team/'


# Demo

View this jekyll theme in action [here](https://y7kim.github.io/agency-jekyll-theme)

For more details, read [documentation](http://jekyllrb.com/)
