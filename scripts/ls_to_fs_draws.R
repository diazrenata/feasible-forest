library(feasibleforest)
library(dplyr)

true_fs_draws <- read.csv(here::here("data", "true_fs_draws.csv"))
ls_samples <- read.csv(here::here("data", "logseries_samples.csv"))


ls_to_fs <- function(ls_row, fs_draws) {

  this_richness = as.numeric(ls_row[1])
  this_abundance = as.numeric(ls_row[2])
  obs_hill1 = as.numeric(ls_row[3])

  these_fs_draws = fs_draws %>%
    filter(richness == this_richness,
           abundance ==this_abundance)

  percentile = obs_to_draw(obs_hill1, these_fs_draws$hill1)

  return(data.frame(
    richness = this_richness,
    abundance = this_abundance,
    hill1 = obs_hill1,
    percentile = percentile
  ))

}


ls_list <- apply(as.matrix(ls_samples), MARGIN = 1, FUN = ls_to_fs, fs_draws = true_fs_draws)

ls_df <- bind_rows(ls_list)

write.csv(ls_df, here::here("data", "ls_to_fs_draws.csv"))
