#' Z score
#'
#' @param obs obs
#' @param mean mean
#' @param sd sd
#'
#' @return z score of obs compared to N(mean, sd)
#' @export
#'
obs_to_norm_z <- function(obs, mean, sd) {

  zscore = (obs - mean) / sd

  zscore

}

#' P value
#'
#' @param obs obs
#' @param mean mean
#' @param sd sd
#'
#' @return p value of obs | N(mean, sd)
#' @export
#'
obs_to_norm_p <- function(obs, mean, sd) {

   p = pnorm(obs, mean = mean, sd = sd)

   p

}
