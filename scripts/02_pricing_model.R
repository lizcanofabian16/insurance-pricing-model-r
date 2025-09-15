# scripts/02_pricing_model.R
source("requirements.R")
source("scripts/01_generate_data.R")

# Cargar datos
data <- read_csv("data/synthetic_insurance_data.csv")

# Preparar datos para modelo
features <- data %>% select(age, gender, driving_experience, vehicle_age, annual_mileage)
target <- data$total_claims_cost

# Dividir datos (80% entrenamiento, 20% prueba)
set.seed(42)
train_index <- createDataPartition(target, p = 0.8, list = FALSE)
X_train <- features[train_index, ]
X_test <- features[-train_index, ]
y_train <- target[train_index]
y_test <- target[-train_index]

# Entrenar modelo
model <- lm(y_train ~ ., data = X_train)

# Hacer predicciones
predictions <- predict(model, newdata = X_test)

# Evaluar modelo
mae <- mean(abs(predictions - y_test))
r_squared <- summary(model)$r.squared

message(glue("MAE: ${round(mae, 2)}"))
message(glue("R²: {round(r_squared, 4)}"))

# Guardar modelo
saveRDS(model, "outputs/pricing_model.rds")
