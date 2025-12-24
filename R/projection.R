#' Temperature projection at given depth
#'
#' @param df data frame with depth and temperatures columns
#' @param depth depth
#' @param temp name of the temperature column
#' @param start initial year
#' @param monthspred number of months to predict
#' @param plot if TRUE plots the projection
#' @import forecast
#' @return forecast of temperatures
#' @export
#'
#' @examples
#' projection(simtemperatures, depth = "-80", temp = "temp.present",
#'            start = "2000", monthspred = "12", plot=FALSE)
projection<-function(df, depth="", temp="", start="2000", monthspred="", plot=FALSE){
  d<-depth
  t<-temp
  ts_data<-ts(dplyr::filter(df, depth==d)[[t]], frequency = 12, start=c(start,1))
  fit<-auto.arima(ts_data)
  forecast<-forecast(fit, h=monthspred)
  if(plot==TRUE){
    plot(forecast,main=paste("Temperature prediction for a depth of", d, "for", monthspred, "months"))
  }
  return(forecast)
}
