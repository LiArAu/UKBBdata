#'
#' Retrieve data from selected fields.
#'
#' @param ids: list of field ids
#' @param keywords: list of field keywords.
#' @param match_name: return will have column names with name or id, default=FALSE, which is field ids.
#'
#' @return: a list of data frames for fields
#'
#' @examples
#' \dontrun{get_field_data(ids = c("20179","20242"))}
#'


get_field_data = function(ids=NULL,keywords=NULL,match_name=FALSE){
  if (!is.null(keywords)){
    ids = ukb_dic[str_detect(ukb_dic$Field,paste(keywords,collapse = "|")),FieldID]
  }
  cats = unlist(ukb_dic %>% filter(FieldID %in% ids) %>% distinct(Category))
  loaded_cats = names(ukb_data_list)
  patterns = paste0("^",ids,"-")
  output = list()

  if (loaded_cats[1] == "ALL"){
    output = ukb_data_list[["ALL"]][str_detect(colnames(ukb_data_list[["ALL"]]),paste(patterns,collapse = "|"))]
  }
  else{
    for (cat in cats){
      if (cat %in% loaded_cats){
        found = ukb_data_list[[cat]][str_detect(colnames(ukb_data_list[[cat]]),paste(patterns,collapse = "|"))]
        if (ncol(found)>0){
          output[[cat]] = cbind(data.frame(eid = ukb_data_list[[cat]][,1]),found)
        }
      }
      else{
        print(paste0("You need to load the category: ",cat))
      }
    }
  }

  return (output)
}


# get_field_data(ids = c("20179","20242","3160"))
