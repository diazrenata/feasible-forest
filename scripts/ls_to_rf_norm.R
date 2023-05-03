library(feasibleforest)
library(dplyr)

rf_predicted_pars <- read.csv(here::here("data", "rf_predicted_pars.csv"))
ls_samples <- read.csv(here::here("data", "logseries_samples.csv"))


ls_to_rf <- function(ls_row, rf_pars) {

  this_richness = as.numeric(ls_row[1])
  this_abundance = as.numeric(ls_row[2])
  obs_hill1 = as.numeric(ls_row[3])

  these_rf_pars = rf_pars %>%
    filter(richness == this_richness,
           abundance ==this_abundance)

  z = obs_to_norm_z(obs_hill1, these_rf_pars$rf_mean, these_rf_pars$rf_sd)
  p = obs_to_norm_p(obs_hill1, these_rf_pars$rf_mean, these_rf_pars$rf_sd)


  return(data.frame(
    richness = this_richness,
    abundance = this_abundance,
    hill1 = obs_hill1,
    z = z,
    p = p
  ))

}


ls_list <- apply(as.matrix(ls_samples), MARGIN = 1, FUN = ls_to_rf, rf_pars = rf_predicted_pars)

ls_df <- bind_rows(ls_list)

write.csv(ls_df, here::here("data", "ls_to_rf_norm.csv"))
