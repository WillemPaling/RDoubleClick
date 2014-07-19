#' DCAuth
#'
#' Authorise and store credentials for the DoubleClick Reporting API
#' 
#' @title Store Credentials for the DoubleClick Reporting API
#'
#' @param client.id
#' @param client.secret
#'
#' @importFrom httr oauth_app oauth_endpoints oauth2.0_token
#' 
#' @return Global credentials list 'SC.Credentials'
#' 
#' @examples
#' \dontrun{
#' DCAuth("client.id", "client.secret")
#' 
#' }
#'
#' @export

DCAuth <- function(client.id,client.secret){
  
  app.dfa <- oauth_app("google",client.id,client.secret)
  app.token <- oauth2.0_token(oauth_endpoints("google"), app.dfa,
    scope = c("https://www.googleapis.com/auth/dfareporting","https://www.googleapis.com/auth/devstorage.read_only"),cache=FALSE)

  DC.token <<- app.token
  DC.authmethod <<- 'oauth'

}