## Clase 06
## Eduard Martinez
## Update: 2023-09-13

## [1.] Checklist
### Lectures previas
### Script de la clase
### Versión de R
R.version.string

### Librerías
# Instalar/llamar pacman
require(pacman)

# Usar la función p_load de pacman para instalar/llamar las librerías de la clase
p_load(rio, skimr, janitor)

## [2.] ¿Qué es tidy-data?
### 2.1. Raw data y tidy data
### 2.2. Reglas de un conjunto de datos tidy
### 2.3. tidyverse
# Instalar y cargar el tidyverse en su entorno de R
library("tidyverse")

### 2.4. Instalar y cargar el tidyverse en su entorno de R

## [3.] Adicionar variables a un conjunto de datos
### 3.1. Conjuntos de datos disponibles en la memoria de R
data(package="datasets")

### 3.2 Función $
# Crear un objeto con la base de datos mtcars
df = as_tibble(x = women)

# Crear una variable con la estatura en centímetros
df$height_cm = df$height*2.54

### 3.3 mutate()
# Generar una variable con la relación weight/height_cm
df = mutate(.data = df , weight_hcm = weight/height_cm)

### 3.4 Generar variables usando condicionales
df$height_180 = ifelse(test=df$height_cm>180 , yes=1 , no=0)
df = mutate(.data=df , sobrepeso = ifelse(test=weight_hcm>=0.85 , yes=1 , no=0))

# Generar una variable con categorías para la relación weight/height_cm
df = mutate(df , category = case_when(weight_hcm>=0.85 ~ "pesado",
                                      weight_hcm>=0.8 & weight_hcm<0.85 ~ "promedio",
                                      weight_hcm<0.8 ~ "liviano"))

### 3.5 Aplicar funciones a variables
# Convertir todas las variables en caracteres
df = mutate_all(.tbl=df , .funs = as.character)

# Convertir solo algunas variables a numéricas
df = mutate_at(.tbl=df , .vars = c("height","weight","height_cm","weight_hcm"),.funs = as.numeric)

# Convertir a numéricas solo las variables que son caracteres
df2 = mutate_if(.tbl=df , .predicate = is.character,.funs = as.numeric)

## [4.] Remover filas y/o columnas
### 4.1 Seleccionar variables
# Seleccionar variables usando partes del nombre
select(.data = db[1:3,], starts_with("Sepal"))

# Seleccionar variables usando el tipo
select_if(.tbl = db[1:3,], is.character)

# Seleccionar variables usando un vector
vars = c("Species","Sepal.Length","Petal.Width")
select(.data = db[1:3,], all_of(vars))

# Deseleccionar variables
select(.data = db[1:3,], -Species)

### 4.2 Remover filas/observaciones
# Remover filas usando condicionales
subset(x = df, height > 180)
filter(.data = df, mass > 100)
