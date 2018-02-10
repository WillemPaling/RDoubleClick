#' reports.list
#'
#' List reports available in via the DoubleClick Reporting API
#' 
#' @title List reports available in via the DoubleClick Reporting API
#'
#' @param profileId The DFA profile ID - use userprofiles.list() to find yours
#' @param results The number of reports to return. Defaults to 10, can be increased to make multiple API requests and get more reports.
#' @param scope The scope that defines which results are returned, default is 'MINE'. Acceptable values are:
#' "ALL": All reports in account.
#' "MINE": My reports. (default)
#' "SHARED_WITH_ME": reports shared with me.
#' @param sortField The field by which to sort the list. 
#' Acceptable values are:
#'   "ID": Sort by file ID.
#' "LAST_MODIFIED_TIME": Sort by 'lastmodifiedAt' field. (default)
#' @param sortOrder Order of sorted results, default is 'DESCENDING', 'ASCENDING' is also valid.
#' @param fields Subset of fields to include in the report
#' @param delay Forced delay between API requests, to prevent errors 
#'
#' @importFrom httr GET stop_for_status content config
#' @importFrom jsonlite fromJSON
#' @importFrom plyr rbind.fill
#' 
#' @return File list (data table)
#' 
#' @examples
#' \dontrun{
#' reports.list(1234567,results=100)
#' 
#' }
#'
#' @export

reports.list <- function(profileId, results=10, scope='', sortField='', sortOrder='', fields='', delay=2){

  # build query string
  if(results>=10) {
    maxResults <- 10
  }
  q.string <- paste0("maxResults=",maxResults)
  if(nchar(scope)) {
    q.string <- paste0(q.string,"&scope=",scope)
  }
  if(nchar(sortField)) {
    q.string <- paste0(q.string,"&sortField=",sortField)
  }
  if(nchar(sortOrder)) {
    q.string <- paste0(q.string,"&sortOrder=",sortOrder)
  }
  if(nchar(fields)) {
    q.string <- paste0(q.string,"&fields=",fields)
  }
  
  report <- data.frame()
  workingResultNum <- 0
  pageToken <- ""
  hasNextPage <- TRUE
  while((workingResultNum<results)&&hasNextPage==TRUE) {
    if(nchar(pageToken)) {
      req.q.string <- paste0(q.string,"&pageToken=",pageToken)
    } else {
      req.q.string <- q.string
    }
    req.url <- paste0("https://www.googleapis.com/dfareporting/v3.0/userprofiles/",profileId,"/reports")
    response <- api.request(req.url,querystring=req.q.string)
    response <- fromJSON(response)
    
    # kill complex nested columns as rbind.fill doesn't handle them
    # criteria, pathToConversionCriteria, schedule, delivery
    # @TODO: unlist instead
    
    response$items$criteria <- NULL
    response$items$reachCriteria <- NULL
    response$items$floodlightCriteria <- NULL
    response$items$crossDimensionReachCriteria <- NULL
    response$items$pathToConversionCriteria <- NULL
    response$items$schedule <- NULL
    response$items$delivery <- NULL
    
    if(nrow(report)>0) {
      report <- rbind.fill(report,data.frame(response$items))
    } else {
      report <- data.frame(response$items)
    }

    pageToken <- response$nextPageToken
    workingResultNum <- nrow(report)
    if(nchar(pageToken)){
      hasNextPage <- TRUE
    } else {
      hasNextPage <- FALSE
    }
    
    Sys.sleep(delay)
    
  }
  
  return(report)

}
