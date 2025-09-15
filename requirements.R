# requirements.R
# Lista de paquetes necesarios
packages <- c("tidyverse", "ggplot2", "dplyr", "readr", 
             "caret", "glue", "ggthemes")

# Instalar paquetes faltantes
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Cargar paquetes
invisible(lapply(packages, library, character.only = TRUE))