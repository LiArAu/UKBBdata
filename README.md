# UK Biobank Dataset

## Intro: 

An R package for working with UKBB datasets including EHR, returns and somatic callings.

## How to use: 

Functions starting with \emph{prepare} help users get familiar with the categories and fields before loading the data.

```r
prepare_get_category() # Get all Category and CategoryID
prepare_get_category(c("Asthma","blood")) # Get full name of categories by keywords

prepare_get_field_ids() # Get all Field and FieldID
prepare_get_field_ids(c("Dementia outcomes","Asthma outcomes")) # Get all Field and FieldID within specified categories

initiate_ukbdata() # Load all the EHR data, which takes long time and need large storage.
initiate_ukbdata(c("Asthma outcomes","Fluid intelligence / reasoning")) # Load data from interested categories only, and each category will be stored as one element in the list.

get_field_data(ids = c("20179","20242")) # Get the data from fields in the categories that you have loaded in the environment.
``` 

## Installing:

Currently this package is not on CRAN. To install use the `devtools` package: 

```r
devtools::install_github('tbilab/UKBBdata')
```
