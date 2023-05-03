# Go from rf_predicted_pars to rf_predicted_draws

library(dplyr)

rf_predicted_pars <- read.csv(here::here("data", "rf_predicted_pars.csv"))

draw_from_norm <- function(a_row) {

  richness = a_row[1]
  abundance = a_row[2]
  sd = a_row[3]
  mean = a_row[4]

  draws = rnorm(n = 1000, mean = mean, sd = sd)

  draws_df = data.frame(
    richness = richness,
    abundance = abundance,
    sd = sd,
    mean = mean,
    hill1 = draws
  )

  draws_df

}

draws_list <- apply(as.matrix(rf_predicted_pars), MARGIN = 1, FUN = draw_from_norm, simplify = F)

draws_df = bind_rows(draws_list)


write.csv(draws_df, here::here("data", "rf_predicted_draws.csv"), row.names = F)
