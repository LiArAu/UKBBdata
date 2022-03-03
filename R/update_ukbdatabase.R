#'
#' Update database as needed.
#'
#' @param rm_pp a list of participant id that need to be removed from the db.
#' @param prev_vid previous version id for the database, eg. "_0302"
#' @param new_vid new version id for the new database, eg. "_today's date"
#'
#' @examples
#' \dontrun{update_ukbdatabase(pp_to_rm[,1], "_0302", "_0305")}
#'



update_ukbdatabase = function(rm_pp, prev_vid, new_vid){
  ukb49913 = aws.s3::s3readRDS(paste0("s3://ukb.tbilab/genome/ukb49913",prev_vid,".rds"))
  ukb49913 = ukb49913 %>% filter(!ukb49913$eid %in% rm_pp)
  aws.s3::s3saveRDS(ukb49913,paste0("s3://ukb.tbilab/genome/ukb49913",new_vid,".rds"))

  columns = colnames(ukb49913)
  column_ids = sapply(columns,FUN=function(x){strsplit(x,"-")[[1]][1]})

  dic = aws.s3::s3readRDS("s3://ukb.tbilab/genome/UKB_Field_Dictionary.rds")

  uni_cats = unique(dic$CategoryID)


  mycluster <- makeCluster(5)
  registerDoParallel(mycluster)

  foreach(cat in uni_cats) %dopar% {
    cat_name = (dic %>% filter(CategoryID == cat) %>% select(Category))[1,1]
    field_ids = unlist(dic %>% filter(CategoryID == cat) %>% select(FieldID))
    tmp_cols = which(column_ids %in% field_ids)
    tmp49913 = ukb49913 %>% select(1,tmp_cols)
    cat = str_replace_all(cat,"/"," or ")
    aws.s3::s3saveRDS(tmp49913,paste0("s3://ukb.tbilab/genome/Categorized",new_vid,"/",cat_name," - ",cat,".rds"))
  }

  print("Database Updated!")
}

# library(doParallel)
# library(foreach)
# library(dplyr)
# library(stringr)
# library(aws.s3)
# # first update - remove withdrawn participants.
# pp_to_rm = read.csv("/home/yajing/MyProjects/TBILAB/ukbb/orig_data/w43397_20220222.csv",header = FALSE)
# prev_vid = ""
# new_vid = "_0302"
# update_ukbdatabase(pp_to_rm[,1], prev_vid, new_vid)
