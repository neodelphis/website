# --- Étape 1: Build ---
# Utilisation d'une image Ruby pour construire le site Jekyll
FROM ruby:3.4.4-alpine AS builder

WORKDIR /usr/src/app

# Installation des dépendances de build
RUN apk add --no-cache build-base

# Copie du Gemfile et installation des gems pour une gestion de cache optimisée
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs=4 --retry=3

# Copie du reste du code source du site
COPY . .

# Construction du site Jekyll. Les fichiers seront générés dans /usr/src/app/_site
RUN jekyll build

# --- Étape 2: Serve ---
# Utilisation d'une image Nginx légère pour servir les fichiers statiques
FROM nginx:stable-alpine

# Copie des fichiers du site construits depuis l'étape précédente vers le répertoire par défaut de Nginx
COPY --from=builder /usr/src/app/_site /usr/share/nginx/html

# Supprimer la configuration par défaut de Nginx
RUN rm -f /etc/nginx/conf.d/default.conf

# Copier votre fichier de configuration Nginx
COPY nginx/conf.d/neodelphis.conf /etc/nginx/conf.d/

# Optionnel : Pour copier directement les fichiers du site (si pas de volume monté)
# COPY _site/ /usr/share/nginx/html/

# Installer Certbot (si pas déjà présent dans l'image)
RUN apk add --no-cache certbot

EXPOSE 80 443

# Commande pour démarrer Nginx (et Certbot si nécessaire, voir point D)
CMD ["nginx", "-g", "daemon off;"]