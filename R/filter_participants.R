#'
#' Filter participants for your loaded dataset.
#'
#' @param rm_pp a list of participant id that need to be removed from the tables.
#' @param table_names a list of names of tables that belong to ukb_data_list.
#'
#' @examples
#' \dontrun{filter_participants(rm_pp,names(ukb_data_list))}
#'


filter_participants = function(rm_pp, table_names){
  for (n in table_names){
    ukb_data_list[[n]] = ukb_data_list[[n]] %>% filter(!eid %in% rm_pp)
  }
}

#filter_participants(rm_pp,names(ukb_data_list))
