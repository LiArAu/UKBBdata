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


prepare_get_field_ids = function(cat = NULL){
    ukb_dic = aws.s3::s3readRDS("s3://ukb.tbilab/genome/UKB_Field_Dictionary.rds")

    if (is.null(cat)){
        field_ids = ukb_dic %>% select(Category,FieldID,Field)
    }
    else{
        field_ids = ukb_dic %>% filter(Category %in% cat) %>% select(Category,FieldID,Field)
    }
    print(field_ids)
    return(field_ids)
}


# prepare_get_field_ids(c("Dementia outcomes","Asthma outcomes"))

