 
library("rjson")
library(dplyr)
library(magrittr)
library(ggplot2)
library(ggpubr)
library(lmerTest)
library(dplyr)
library(magrittr)
library(knitr)
library(emmeans)
library(chron)
library(tinytex)

# data format
clean_users <- function(main_df) {
  main_df%<>%
    mutate(familar = as.character(familar),
            familar = ifelse(familar == 'Yes', '1', familar),
            familar = ifelse(familar == 'No','2',  familar),
             
            )
 
    main_df%<>%
      mutate(frequent = as.character(frequent),
            frequent = ifelse(frequent == '1 (Never)','1',  frequent),
            frequent = ifelse(frequent == '2 (Rarely)','1',  frequent),
            frequent = ifelse(frequent == '3 (Sometimes)', '2', frequent),
            frequent = ifelse(frequent == '4 (Frequently)','2',  frequent),
             
            )

 
  return(main_df)
}

main_study_data <- fromJSON(file = "./merge_main_logistic.json")
 
data_class <- class(main_study_data)
main_df <- data.frame(
 
  true_label=sapply(main_study_data, function(x) x$true_label),
 
  familar = sapply(main_study_data, function(x) x$familar),
  frequent = sapply(main_study_data, function(x) x$frequent),
  identify=sapply(main_study_data, function(x) x$identify),
  pid=sapply(main_study_data, function(x) x$prolific_pid)
)

 
   
main_df1<-clean_users(main_df)
main_df1$true_label <-factor(main_df1$true_label,levels = c("phish", "benign","apw_lab_footimgs","apw_lab_typoss","apw_lab_repasss","apw_lab_backimgs","apw_com"))
 
main_df1$familar <-factor(main_df1$familar,levels = c("2", "1"))
main_df1$frequent <-factor(main_df1$frequent,levels = c("1", "2"))  
 
# mixed effect logistic regression model
#refer to table 3 in sec 5.2, webpage classification analysis
modelAnswer= glmer(identify ~ familar +
                        frequent + true_label +  
                        (1 | pid),
                       data=main_df1, family=binomial(),
                       control=glmerControl(optimizer="bobyqa",optCtrl=list(maxfun=2e5))
                       )

answer_sum <- summary(modelAnswer)
print(answer_sum)
 