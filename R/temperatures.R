#' temperatures data
#'
#' A data frame of sea temperature observations. Data is obtanined from IDESCAT
#' https://www.idescat.cat/indicadors/?id=aec&n=15196&col=1.
#'
#' @format A data frame of 864 rows and 7 columns:
#' \describe{
#'   \item{depth}{Indicates the depth at which temperature is measured}
#'   \item{month}{Month at which the temperature is recorded}
#'   \item{year}{Year when the temperature is recorded}
#'   \item{temp.present}{Temperature}
#'   \item{temp.hist}{Previous period temperature}
#'   \item{ref_hist}{Period of historical reference}
#'   \item{diff}{Difference between temperatures}
#'
#' }
"temper