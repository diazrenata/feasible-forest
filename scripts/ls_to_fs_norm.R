library(feasibleforest)
library(dplyr)

true_fs_pars <- read.csv(here::here("data", "true_fs_pars.csv"))
ls_samples <- read.csv(here::here("data", "logseries_samples.csv"))


ls_to_fs <- function(ls_row, fs_pars) {

  this_richness = as.numeric(ls_row[1])
  this_abundance = as.numeric(ls_row[2])
  obs_hill1 = as.numeric(ls_row[3])

  these_fs_pars = fs_pars %>%
    filter(richness == this_richness,
           abundance ==this_abundance)

  z = obs_to_norm_z(obs_hill1, these_fs_pars$mean, these_fs_pars$sd)
  p = obs_to_norm_p(obs_hill1, these_fs_pars$mean, these_fs_pars$sd)


  return(data.frame(
    richness = this_richness,
    abundance = this_abundance,
    hill1 = obs_hill1,
    z = z,
    p = p
  ))

}


ls_list <- apply(as.matrix(ls_samples), MARGIN = 1, FUN = ls_to_fs, fs_pars = true_fs_pars)

ls_df <- bind_rows(ls_list)

write.csv(ls_df, here::here("data", "ls_to_fs_norm.csv"))
