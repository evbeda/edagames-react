FROM node:14.18.1 AS build-step

WORKDIR /build
COPY package.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:1.18-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build-step /build/build /frontend/build

# Expose port 80 for HTTP Traffic 
EXPOSE 80

# start the nginx web server

CMD ["nginx", "-g", "daemon off;"]
