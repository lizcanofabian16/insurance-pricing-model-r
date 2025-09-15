# scripts/03_visualization.R
source("requirements.R")
model <- readRDS("outputs/pricing_model.rds")
data <- read_csv("data/synthetic_insurance_data.csv")

# 1. Importancia de Variables
coefficients_df <- broom::tidy(model) %>%
  filter(term != "(Intercept)") %>%
  mutate(term = fct_reorder(term, estimate))

ggplot(coefficients_df, aes(x = estimate, y = term, fill = estimate > 0)) +
  geom_col(show.legend = FALSE) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  labs(title = "Importancia de Variables en el Modelo de Pricing",
       x = "Coeficiente (Impacto en la Prima)",
       y = "") +
  theme_minimal() +
  scale_fill_manual(values = c("red3", "green4"))

ggsave("outputs/feature_importance.png", width = 8, height = 5)

# 2. Distribución de Primas
data$premium <- predict(model, newdata = data) * 1.20

ggplot(data, aes(x = premium)) +
  geom_histogram(fill = "lightcoral", alpha = 0.8, bins = 30) +
  geom_vline(aes(xintercept = mean(premium)), linetype = "dashed") +
  labs(title = "Distribución de Primas en el Portafolio",
       x = "Prima Calculada ($)",
       y = "Número de Asegurados") +
  theme_minimal()

ggsave("outputs/premium_distribution.png", width = 8, height = 5)

# 3. Relación Edad vs. Prima
ggplot(data, aes(x = age, y = premium)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", color = "red3") +
  labs(title = "Relación entre Edad y Prima",
       x = "Edad del Conductor",
       y = "Prima Calculada ($)") +
  theme_minimal()

ggsave("outputs/age_vs_premium.png", width = 8, height = 5)

# 4. Primas por Género (Boxplot)
data$gender_label <- ifelse(data$gender == 0, "Mujer", "Hombre")

ggplot(data, aes(x = gender_label, y = premium, fill = gender_label)) +
  geom_boxplot(show.legend = FALSE) +
  labs(title = "Distribución de Primas por Género",
       x = "", y = "Prima Calculada ($)") +
  theme_minimal() +
  scale_fill_manual(values = c("pink", "lightblue"))

ggsave("outputs/premium_by_gender.png", width = 7, height = 5)