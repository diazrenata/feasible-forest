#' Fit a random forest
#'
#' @param par mean or sd
#' @return fitted random forest
#' @export
#'
#' @importFrom randomForest randomForest
fit_forest <- function(par = "mean") {

  train_dat <- fs_train

  if(par == "mean") {
    this_rf <- randomForest::randomForest(mean ~ richness + abundance, data = train_dat)
  } else if (par == "sd") {
    this_rf <- randomForest::randomForest(sd ~ richness + abundance, data = train_dat)
  } else {
    warning("Not a good par spec")
  }

  this_rf
}

