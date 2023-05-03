library(dplyr)
library(meteR)
library(hillR)


rf_predicted_pars <- read.csv(here::here("data", "rf_predicted_pars.csv"))

draw_from_ls <- function(a_row) {

  richness = as.numeric(a_row[1])
  abundance  = as.numeric(a_row[2])

  this_esf = meteR::meteESF(S0 = richness, N0 = abundance)

  foo <- try(meteR::sad(this_esf))

  if("try-error" %in% class(foo)) {

    ls_df = data.frame(
      richness = richness,
      abundance = abundance,
      hill1 = NA
    )
    return(ls_df)
  }

  sad_draw = as.matrix(meteR::meteDist2Rank(foo)) %>%
    t()

  ls_df = data.frame(
    richness = richness,
    abundance = abundance,
    hill1 = hillR::hill_taxa(sad_draw, q = 1)
  )

  ls_df

}

ls_list <- apply(as.matrix(rf_predicted_pars), MARGIN = 1, FUN = draw_from_ls, simplify = F)

ls_df <- bind_rows(ls_list)

write.csv(ls_df, here::here("data", "logseries_samples.csv"), row.names = F)
