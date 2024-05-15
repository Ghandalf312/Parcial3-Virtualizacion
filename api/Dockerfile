# Usa la imagen oficial de Python como imagen base.
FROM python:3.9-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos de requerimientos primero para aprovechar la caché de las capas de Docker
COPY requirements.txt ./

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del código de la aplicación al contenedor
COPY . .

# Informa a Docker que el contenedor escucha en el puerto 5050 en tiempo de ejecución.
EXPOSE 5050

# Define el comando para ejecutar la aplicación.
CMD ["python", "app.py"]
