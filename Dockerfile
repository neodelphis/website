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

# Exposition du port 80 et démarrage de Nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

