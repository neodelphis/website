
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
