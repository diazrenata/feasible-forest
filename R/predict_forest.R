#' Predict parameters from fitted random forest
#'
#' @param s s
#' @param n n
#'
#' @return df
#' @export
predict_forest <- function(s, n) {

  mean_rf = mean_rf
  sd_rf = sd_rf


  newdat <- data.frame(richness = s, abundance = n)

  meanpred <- predict(mean_rf, newdata = newdat)

  sdpred <- predict(sd_rf, newdata = newdat)

  out <- data.frame(
    richness = s,
    abundance = n,
    predicted_mean = meanpred,
    predicted_sd = sdpred
  )

  out

}
