library(dplyr)

all_di <- read.csv("https://raw.githubusercontent.com/diazrenata/scadsanalysis/master/analysis/reports/submission2/all_di.csv")

di_sel <- all_di %>%
  select(dat, site, singletons, s0, n0, nparts, shannon, shannon_percentile)

di_hill <- di_sel %>%
  mutate(hill1 = exp(shannon))

write.csv(di_hill, here::here("scripts", "all_di_hill.csv"), row.names = F)

di_hill_small <- di_hill %>%
  filter(s0 < 200, n0 < 20000) %>%
  filter(s0 > 2) %>%
  filter(n0 > (s0 + 1))
write.csv(di_hill_small, here::here("scripts", "filtered_di_hill.csv"), row.names = F)
