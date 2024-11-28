#!/bin/bash

# Función para registrar mensajes en un archivo de log
log_message() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${timestamp}] ${message}" >> log.txt
}

# Verificar si se ha proporcionado un mensaje de commit
if [ -z "$1" ]; then
  echo "Error: Por favor, proporciona un mensaje para el commit."
  log_message "Error: No se proporcionó un mensaje para el commit."
  exit 1
fi

# Registrar el inicio del script
log_message "Inicio del script: commit con mensaje '$1'."

# Añadir los cambios al área de staging
git add .
if [ $? -ne 0 ]; then
    log_message "Error al ejecutar 'git add'."
    exit 1
fi

# Realizar el commit con el mensaje proporcionado
git commit -m "$1"
if [ $? -ne 0 ]; then
    log_message "Error al ejecutar 'git commit'."
    exit 1
fi
log_message "Commit realizado con éxito."

# Subir los cambios a la rama main
git push origin main
if [ $? -ne 0 ]; then
    log_message "Error al ejecutar 'git push'."
    exit 1
fi
log_message "Push realizado con éxito a la rama 'main'."

# Publicar en GitHub Pages usando Quarto
quarto publish gh-pages --no-render --no-prompt
if [ $? -ne 0 ]; then
    log_message "Error al publicar con Quarto."
    exit 1
fi
log_message "Publicación en GitHub Pages completada con éxito."

# Finalización del script
log_message "Fin del script."
