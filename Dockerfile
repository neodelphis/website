# --- Étape 1: Build ---
# Utilisation de l'image officielle Jekyll pour un environnement optimisé et sécurisé.
# Cette image inclut déjà Ruby, Bundler et les dépendances de build nécessaires.
FROM jekyll/builder:4 AS builder

# Le WORKDIR par défaut est /usr/src/app et l'utilisateur est 'jekyll'.

# Copie du Gemfile et installation des gems pour une gestion de cache optimisée
# L'option --chown garantit que les fichiers appartiennent à l'utilisateur non-root 'jekyll'.
# Copier ces fichiers en premier permet de tirer parti du cache Docker :
# si seul le code du site change, cette étape ne sera pas ré-exécutée.
COPY --chown=jekyll:jekyll Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# Copie du reste du code source du site
COPY --chown=jekyll:jekyll . .

# Construction du site Jekyll. Les fichiers seront générés dans /usr/src/app/_site
# Utiliser "bundle exec" est une bonne pratique pour s'assurer que la version de Jekyll
# définie dans le Gemfile.lock est bien celle qui est utilisée.
RUN bundle exec jekyll build --verbose

# --- Étape 2: Serve ---
# Utilisation d'une image Nginx légère pour servir les fichiers statiques
FROM nginx:stable-alpine

# Copie des fichiers du site construits depuis l'étape précédente vers le répertoire par défaut de Nginx
COPY --from=builder /usr/src/app/_site /usr/share/nginx/html

# Exposition du port 80 pour Nginx.
EXPOSE 80

# Commande pour démarrer Nginx en avant-plan.
CMD ["nginx", "-g", "daemon off;"]