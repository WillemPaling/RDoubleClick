#' DCSetKey
#'
#' Set your server API key for the DoubleClick Reporting API
#' 
#' @title Store Credentials for the DoubleClick Reporting API
#'
#' @param key
#' 
#' @return Global credentials list 'SC.Credentials'
#' 
#' @examples
#' \dontrun{
#' DCSetKey("your-key-here")
#' 
#' }
#'
#' @export

DCSetKey <- function(key){

  DC.key <<- key
  DC.authmethod <<- 'key'

}