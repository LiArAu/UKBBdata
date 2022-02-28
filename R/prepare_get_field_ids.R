#'
#' Get Field IDs in the Category before loading the data.
#' 
#' @param categories: All the categories that you need.
#' 
#' @return:
#'  \itemize{
#'   \item `field_ids`: Field IDs in the category you input.
#' }
#' 
#' @examples
#' \dontrun{prepare_get_field_ids()}
#' \dontrun{prepare_get_field_ids(c("Dementia outcomes","Asthma outcomes"))}
#' 


prepare_get_field_ids = function(cat = c(FALSE)){
    ukb_dic = aws.s3::s3readRDS("s3://ukb.tbilab/genome/UKB_Field_Dictionary.rds")

    if (cat[1] == FALSE){
        field_ids = ukb_dic %>% select(Category,FieldID)
    }
    else{
        field_ids = ukb_dic %>% filter(Category %in% cat) %>% select(Category,FieldID)
    }

    field_ids <<- field_ids
}


# prepare_get_field_ids(c("Dementia outcomes","Asthma outcomes"))

