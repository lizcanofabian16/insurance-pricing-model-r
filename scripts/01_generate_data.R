# scripts/01_generate_data.R
set.seed(42)
n_samples <- 1000

# Generar datos sintéticos
data <- tibble(
  age = sample(18:70, n_samples, replace = TRUE),
  gender = sample(0:1, n_samples, replace = TRUE),
  driving_experience = sample(1:50, n_samples, replace = TRUE),
  vehicle_age = sample(0:20, n_samples, replace = TRUE),
  annual_mileage = sample(5000:25000, n_samples, replace = TRUE)
) %>%
  mutate(
    total_claims_cost = 100 * age +
      -50 * gender +
      20 * driving_experience +
      30 * vehicle_age +
      0.5 * annual_mileage +
      rnorm(n_samples, 0, 500)
  )

# Guardar datos
write_csv(data, "data/synthetic_insurance_data.csv")
message("Datos sintéticos generados y guardados")
