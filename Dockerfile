# 1. Build Stage: Compile the Vue.js project
FROM node:lts AS build-stage

WORKDIR /app

# Copier package.json et package-lock.json pour installer les dépendances
COPY package*.json ./

RUN npm install

# Copier tout le projet dans le conteneur
COPY . .

# Compiler l'application Vue.js pour la production
RUN npm run build

# 2. Production Stage: Serve with Nginx
FROM nginx:latest

# Copier les fichiers compilés dans le conteneur Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Exposer le port 80 pour l'application
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
