#'
#' Pull ukbdata from aws s3.
#' 
#' @param categories: All the categories that you might be working on.

#' @return:
#'  \itemize{
#'   \item `ukb_dic`: dictionary of ukbiobank data
#'   \item `ukb_data_list`: all the data you pulled out.
#' }
#' 
#' @examples
#' \dontrun{initiate_ukbdata()}
#' \dontrun{initiate_ukbdata(c("Dementia outcomes","Asthma outcomes"))}
#' 

initiate_ukbdata <- function(cats = c("ALL")){
    
    ukb_dic = aws.s3::s3readRDS("s3://ukb.tbilab/genome/UKB_Field_Dictionary.rds")
    ukb_dic <<- ukb_dic

    ukb_data_list = list()

    if (cats[1] == "ALL"){
        ukb_data_list["ALL"] = aws.s3::s3readRDS("s3://ukb.tbilab/genome/ukb49913.rds")
        }
    else{
        for (cat in cats){
            orig_cat = cat
            cat = str_replace_all(cat,"/"," or ")
            ukb_data_list[[orig_cat]] = aws.s3::s3readRDS(paste0("s3://ukb.tbilab/genome/Categorized/",cat,".rds"))
            }
        }

    ukb_data_list <<- ukb_data_list
    print("Completed!")
    }

initiate_ukbdata(c("Asthma outcomes","Fluid intelligence / reasoning"))
head(ukb_data_list$`Asthma outcomes`)
head(ukb_data_list$`Fluid intelligence / reasoning`)
