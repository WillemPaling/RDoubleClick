#' reports.run
#'
#' Run previously defined report from DoubleClick Reporting API
#' 
#' @title Run previously defined report from DoubleClick Reporting API
#'
#' @param profileId The ID of the profile associated with the report
#' @param reportId The ID of the report
#'
#' @importFrom httr GET stop_for_status content config
#' @importFrom stringr str_split
#' 
#' @return data table containing report data
#' 
#' @examples
#' \dontrun{
#' reports.run(1234567,8765431)
#' 
#' }
#'
#' @export


reports.run <- function(profileId, reportId){

  req.url <- paste0("https://www.googleapis.com/dfareporting/v2.7/userprofiles/",profileId,"/reports/",reportId,"/run")
  response <- fromJSON(api.request(req.url,querystring="synchronous=true",method='POST'))
  
  # now that the report has run, get the report
  return(files.get(response$id,response$reportId))

}
