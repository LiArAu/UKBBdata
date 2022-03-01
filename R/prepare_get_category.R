#'
#' Get name of the categories.
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


prepare_get_category = function(keyword = NULL){
    cat_list = aws.s3::s3readRDS("s3://ukb.tbilab/genome/UKB_Category_ID.rds")
    if (!is.null(keyword)){
        cat_list = cat_list[str_detect(cat_list$Category,paste(keyword,collapse = '|')),]
        }
    print(cat_list)
    return(cat_list)
}

# prepare_get_category(c("Asthma","blood"))
