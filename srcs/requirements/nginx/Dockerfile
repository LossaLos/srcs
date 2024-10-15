# Utiliser l'image de base Debian 11
FROM debian:11

# Installer les paquets nécessaires, y compris gettext pour envsubst
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    gettext \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Créer les répertoires nécessaires
RUN mkdir -p /run/nginx /var/www/html /etc/ssl/certs /etc/ssl/private /var/www/certbot

# Copier le fichier de configuration Nginx en tant que template
COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

# Définir l'argument DOMAIN_NAME
ARG DOMAIN_NAME

# Exporter la variable DOMAIN_NAME dans l'environnement
ENV DOMAIN_NAME=${DOMAIN_NAME}

# Substituer la variable DOMAIN_NAME dans le fichier de configuration
RUN envsubst '$DOMAIN_NAME' < /etc/nginx/conf.d/nginx.conf > /etc/nginx/conf.d/default.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt \
        -subj "/C=FR/ST=Lyon/L=Lyon/O=42 School/OU=fprevot/CN=${DOMAIN_NAME}"

# Copier les fastcgi_params
COPY ./tools/fastcgi_params /etc/nginx/

EXPOSE 443

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
