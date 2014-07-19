#' userprofiles.list
#'
#' Authorise and store credentials for the DoubleClick Reporting API
#' 
#' @title Store Credentials for the DoubleClick Reporting API
#'
#' @param profileId
#' @param maxResults
#' @param pageToken
#' @param scope
#' @param sortField
#' @param sortOrder
#' @param fields
#'
#' @importFrom httr oauth_app oauth_endpoint oauth2.0_token
#' @importFrom jsonlite fromJSON
#' 
#' @return Global credentials list 'SC.Credentials'
#' 
#' @examples
#' \dontrun{
#' userprofiles.list("client.id", "client.secret")
#' 
#' }
#'
#' @export

userprofiles.list <- function(client.id,client.secret){

  req <- GET("https://www.googleapis.com/dfareporting/v1.3/userprofiles",
    config(token = DC.token))
  stop_for_status(req)
  response <- fromJSON(content(req,as='text'))

  return(response$items)
  
}
