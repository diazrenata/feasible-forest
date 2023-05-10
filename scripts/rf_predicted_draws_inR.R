# Fit a random forest in R and generate predicted draws from it

library(dplyr)
library(randomForest)

train_dat = read.csv(here::here("data", "true_fs_pars_train.csv")) %>%
  select(-X)

test_dat = read.csv(here::here("data", "true_fs_pars_test.csv")) %>%
  select(-X)

all.rf <- randomForest(mean ~ richness + abundance, data = train_dat, keep.forest =T)

allsd.rf <- randomForest(sd ~ richness + abundance, data = train_dat, keep.forest =T)


r_rf_predicted_pars <- test_dat %>%
  mutate(rf_sd =  as.numeric(predict(allsd.rf,  test_dat[, c('richness', 'abundance')], type = 'response')),
         rf_mean = as.numeric(predict(all.rf,  test_dat[, c('richness', 'abundance')], type = 'response'))) %>%
  select(richness, abundance, rf_sd, rf_mean)


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

draws_list <- apply(as.matrix(r_rf_predicted_pars), MARGIN = 1, FUN = draw_from_norm, simplify = F)

draws_df = bind_rows(draws_list)

write.csv(r_rf_predicted_pars, here::here("data", "r_rf_predicted_pars.csv"), row.names = F)

write.csv(draws_df, here::here("data", "r_rf_predicted_draws.csv"), row.names = F)

