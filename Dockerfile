# ===== Build Angular =====
# Je compile Angular sans embarquer Node en production
FROM node:20-alpine AS build

# Je définis /app comme répertoire de travail
WORKDIR /app

# Je copie package.json et package-lock.json et j'installe les dépendances, le COPY ici permet de profiter du cache Docker et d'accélérer les builds 
COPY package.json package-lock.json ./
RUN npm ci

# Je copie le reste des fichiers et je lance la compilation Angular
COPY . .
RUN npm run build

# ===== Nginx runtime =====
# Image officielle Nginx en alpine pour la légéreté et plsu récente que le readme pour la sécurité (moins de CVE)
FROM nginx:1.29.4-alpine

# Copie de la configuration Nginx personnalisée
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copie UNIQUEMENT les fichiers statiques Angular
COPY --from=build /app/dist/*/browser/ /app/

# J'expose le port 80 et lance Nginx en premier plan
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
