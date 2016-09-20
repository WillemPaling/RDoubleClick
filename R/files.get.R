#' files.get
#'
#' Get file from DoubleClick Reporting API
#' 
#' @title Get file from DoubleClick Reporting API
#'
#' @param fileId The ID of the report file - use files.list(profileId) to find this
#' @param reportId The ID of the report - use files.list(profileId) to find this
#'
#' @importFrom httr GET stop_for_status content config
#' @importFrom stringr str_split
#' 
#' @return data table containing report data
#' 
#' @examples
#' \dontrun{
#' files.get(1234567,8765431)
#' 
#' }
#'
#' @export


files.get <- function(fileId, reportId){

  req.url <- paste0("https://www.googleapis.com/dfareporting/v2.5/reports/",reportId,"/files/",fileId)
  response <- api.request(req.url,querystring="alt=media")
  
  # we have to remove parts of this text to get a readable table
  # first remove everything prior to the report field definitions (header row)
  response <- str_split(response,"Report Fields\n")[[1]][2]
  # then remove the totals row
  response <- str_split(response,"\nGrand Total")[[1]][1]
  
  report <- read.csv(text=response,header=TRUE,sep=",")
  
  return(report)

}
