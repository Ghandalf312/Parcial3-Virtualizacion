# Usa la imagen base de Nginx con Alpine por su pequeño tamaño.
FROM nginx:alpine

# Copia tu archivo HTML estático al directorio de Nginx para archivos estáticos.
COPY index.html /usr/share/nginx/html

# No es necesario definir CMD porque la imagen base ya contiene un comando para arrancar Nginx.
EXPOSE 80
