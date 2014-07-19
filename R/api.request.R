#' api.request
#'
#' Internal Function: Make API Request

api.request <- function(url, querystring=""){

  if(DC.authmethod=='oauth') {
    req <- GET(url,query=querystring,config(token = DC.token))
  } else {
    if(nchar(querystring)>0) {
      querystring <- paste0(querystring,'&key=',DC.key)
    }
    req <- GET(url,query=querystring)
  }
  
  stop_for_status(req)
  response <- content(req,as='text')

  return(response)
}