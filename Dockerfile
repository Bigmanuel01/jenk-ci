FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY index.html .
COPY index.js .
COPY style.css .
COPY assets ./assets
COPY vendor ./vendor

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]