#' userprofiles.list
#'
#' Lists available profiles for retrieving reports.
#' 
#' @title Lists available profiles for retrieving reports.
#'
#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' 
#' @return Global credentials list 'SC.Credentials'
#' 
#' @examples
#' \dontrun{
#' userprofiles.list()
#' 
#' }
#'
#' @export

userprofiles.list <- function(client.id,client.secret){

  req.url <- "https://www.googleapis.com/dfareporting/v3.0/userprofiles"
  response <- fromJSON(api.request(req.url))

  return(response$items)
  
}
