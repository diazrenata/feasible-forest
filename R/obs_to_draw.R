#' percentile
#'
#' @param obs obs
#' @param draws comparisons
#'
#' @return percentile (percent of draws <= obs)
#' @export
#'
obs_to_draw <- function(obs, draws) {

  perc = sum(draws <= obs) / length(draws)

  perc

}
