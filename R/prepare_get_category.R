#'
#' Get Category name before loading the data.
#' 
#' @param keyword: keyword of the category name
#' 
#' @return:
#'  \itemize{
#'   \item `cat_list`: Category IDs and Names you need.
#' }
#' 
#' @examples
#' \dontrun{prepare_get_category()}
#' \dontrun{prepare_get_category(c("Asthma"))}
#' 


prepare_get_category = function(keyword = c(FALSE)){
    cat_list = aws.s3::s3readRDS("s3://ukb.tbilab/genome/UKB_Category_ID.rds")
    if (keyword[1] != FALSE){
        cat_list = cat_list[str_detect(cat_list$Category,paste(keyword,collapse = '|')),] 
        }
    print(cat_list)
    cat_list <<- cat_list
}

# prepare_get_category(c("Asthma","blood"))
