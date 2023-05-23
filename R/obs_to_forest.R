#' Compared observed to random forest
#'
#' @param hill1 obs
#' @param s s
#' @param n n
#'
#' @return z score of obs | feasible set as predicted by rf
#' @export
#'
obs_to_forest_z <- function(hill1, s, n) {

  forestpreds <- predict_forest(s, n)

  obs_z <- obs_to_norm_z(hill1, forestpreds$predicted_mean[1], forestpreds$predicted_sd[1])

  obs_z
}
