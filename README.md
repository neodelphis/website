# Site Web Neodelphis

Ce dépôt contient le code source du site web [www.neodelphis.com](https://www.neodelphis.com), un site statique généré avec Jekyll et servi via Nginx.

## Prérequis

*   Docker
*   Docker Compose

## Environnement de Développement

L'environnement de développement est conçu pour le rechargement à chaud, vous permettant de voir vos modifications en direct.

1.  **Lancer le serveur de développement :**
    ```bash
    docker compose up
    ```
    Cette commande va :
    *   Construire l'image de développement (basée sur l'étape `builder` du `Dockerfile`).
    *   Installer les dépendances Ruby (gems).
    *   Lancer le serveur Jekyll sur http://localhost:4000.

2.  **Accéder au site :**
    Ouvrez votre navigateur et allez sur [http://localhost:4000](http://localhost:4000).

3.  **Arrêter le serveur :**
    Appuyez sur `Ctrl+C` dans le terminal, puis exécutez :
    ```bash
    docker compose down
    ```

**Note sur le fonctionnement :** Le fichier `docker-compose.yml` monte le répertoire courant du projet dans le conteneur. Le serveur Jekyll surveille les changements de fichiers et reconstruit le site automatiquement.

### Note pour les utilisateurs de Mac Apple Silicon (M1/M2/M3)

Lors du lancement de l'environnement de développement, vous pourriez rencontrer l'avertissement suivant :
```
! website-dev The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8)
```
Cet avertissement est normal. L'image de base `jekyll/builder:4` est conçue pour une architecture de processeur `amd64` (Intel/AMD). Sur un Mac avec une puce Apple Silicon (`arm64`), Docker utilise une couche d'émulation (QEMU) pour la faire fonctionner.

**Conséquences :** Les performances peuvent être légèrement réduites (temps de build ou de rechargement plus longs). Cependant, l'application reste parfaitement fonctionnelle pour le développement.

## Déploiement en Production

La production utilise une image Docker optimisée contenant Nginx et uniquement les fichiers statiques du site.

1.  **Assurez-vous que le réseau `proxy-net` existe.** Ce site est conçu pour être déployé derrière un reverse proxy.
    ```bash
    docker network create proxy-net
    ```

2.  **Déployer ou mettre à jour le site :**
    ```bash
    docker compose -f docker-compose.prod.yml up -d --build
    ```
    Cette commande va :
    *   Construire l'image de production complète (en utilisant la construction multi-étapes du `Dockerfile`).
    *   Lancer un conteneur Nginx pour servir le site.

3.  **Arrêter le service de production :**
    ```bash
    docker compose -f docker-compose.prod.yml down
    ```

## Gestion du Contenu

Le site est basé sur le thème Jekyll "Agency". La plupart du contenu peut être modifié dans des fichiers de configuration ou des répertoires spécifiques.

*   **Configuration générale :**
    Le fichier `_config.yml` contient les paramètres principaux du site comme le titre, la description, les informations de contact et les profils sociaux.

*   **Portfolio (`_posts`) :**
    Chaque projet du portfolio est un "post" Jekyll dans le répertoire `_posts`. Suivez la convention de nommage `AAAA-MM-JJ-nom-du-projet.md`. Les images associées se trouvent dans `img/portfolio/`.

*   **Section "Technos" (`_includes/about.html`) :**
    Le contenu de la timeline des technologies est directement dans le fichier `_includes/about.html`. Les images sont dans `img/about/`.

*   **Section "Team" (`_config.yml`) :**
    Les informations sur les membres de l'équipe sont définies dans la section `people` du fichier `_config.yml`.

## Structure du projet

```
.
├── _includes/         # Partials HTML (ex: about.html)
├── _layouts/          # Modèles de page Jekyll
├── _posts/            # Articles du blog / Projets du portfolio
├── _site/             # (Généré) Site statique final. Non versionné.
├── css/               # Fichiers CSS additionnels
├── img/               # Images pour le portfolio, la team, etc.
├── js/                # Fichiers JavaScript
├── _config.yml        # Fichier de configuration principal de Jekyll
├── docker-compose.yml # Configuration Docker pour le développement
├── docker-compose.prod.yml # Configuration Docker pour la production
├── Dockerfile         # Instructions pour construire les images Docker
└── README.md          # Ce fichier
```
