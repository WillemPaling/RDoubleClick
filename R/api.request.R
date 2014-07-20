#' api.request
#'
#' Internal Function: Make API Request
#' @importFrom httr GET POST stop_for_status content config

api.request <- function(url, querystring="",method="GET"){

  if(DC.authmethod=='oauth') {
    if(method=="GET") {
      req <- GET(url,query=querystring,config(token = DC.token))
    } else if (method=="POST") {
      # requires a dummy body to avoid a content-length error
      req <- POST(paste0(url,"?",querystring),config(token = DC.token),multipart=FALSE,body=list('dummy'))
    }
  }
  
  stop_for_status(req)
  response <- content(req,as='text')

  return(response)
}