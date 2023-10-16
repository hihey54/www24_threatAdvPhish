
library("rjson")
library(dplyr)
library(magrittr)

# adjust data format
clean_participants <- function(main_df) { 
  main_df%<>%
    mutate(gender = as.character(gender),
            gender = ifelse(gender == 'Female', '1', gender),
            gender = ifelse(gender == 'Male','2',  gender),
            gender = ifelse(gender == 'Non-binary / third gender','3',  gender),
            gender = ifelse(gender == 'Prefer not to say','4',  gender),
             
            )

 

    main_df%<>%
      mutate(age = as.character(age),
            age = ifelse(age == '18-29','1',  age),
            age = ifelse(age == '30-39','1',  age),
            age = ifelse(age == '40-49', '2', age),
            age = ifelse(age == '50-59','2',  age),
            age = ifelse(age == '60-69','2',  age),
            age = ifelse(age == '70 or above','2',  age),
            age = ifelse(age == 'Prefer not to say','7',  age),
             
            )
    main_df%<>%
     
      mutate(education= as.character(education),
            education = ifelse(education == 'Some high school or less', '1', education),
            education = ifelse(education == 'High school diploma or GED','1',  education),
            education = ifelse(education == 'Some college, but no degree','1',  education),
            education = ifelse(education == 'Associates or technical degree', '1', education),
            education = ifelse(education == "Bachelor’s degree",'2',  education),
            education = ifelse(education == 'Graduate or professional degree (MA, MS, MBA, PhD, JD, MD, DDS etc.)','2',  education),
            education = ifelse(education == 'Prefer not to say','3',  education),
            
            ) 
    
    main_df%<>%
      mutate(phish_know = as.character(phish_know),
            phish_know = ifelse(phish_know == 'Yes','1', phish_know ),
            phish_know = ifelse(phish_know == 'No','2',  phish_know),
            phish_know = ifelse(phish_know == 'Prefer not to say','3',  phish_know),
             
            )

    main_df%<>%
      mutate(computer_know = as.character(computer_know),
            computer_know = ifelse(computer_know == 'Yes','1', computer_know ),
            computer_know = ifelse(computer_know == 'No','2',  computer_know),
            computer_know = ifelse(computer_know == 'Prefer not to say','3',  computer_know),
            
            )

    main_df%<>%
      mutate(security_know = as.character(security_know),
            security_know = ifelse(security_know == 'Yes','1', security_know ),
            security_know = ifelse(security_know == 'No','2',  security_know),
            security_know = ifelse(security_know == 'Prefer not to say','3',  security_know), 
            ) 
 
  return(main_df)
}

main_study_data <- fromJSON(file = "./merged_main_survey.json")
print(length(main_study_data))
data_class <- class(main_study_data)
print(data_class)

main_df <- data.frame(
 
  duration=sapply(main_study_data, function(x) x$duration),
  tp = sapply(main_study_data, function(x) x$tp),
  tn = sapply(main_study_data, function(x) x$tn),
  age = sapply(main_study_data, function(x) x$age),
  gender=sapply(main_study_data, function(x) x$gender),
  phish_know=sapply(main_study_data, function(x) x$phish_know),
  computer_know=sapply(main_study_data, function(x) x$computer_know),
  security_know=sapply(main_study_data, function(x) x$security_know),
  education=sapply(main_study_data, function(x) x$education)
)  
main_df$accuracy <- c((main_df$tp+main_df$tn)/15)     
main_df1<-clean_participants(main_df)
main_df1$gender <-factor(main_df1$gender,levels = c("1", "2"))
main_df1$phish_know <-factor(main_df1$phish_know,levels = c("2", "1"))
main_df1$computer_know <-factor(main_df1$computer_know,levels = c("2", "1"))
main_df1$security_know <-factor(main_df1$security_know,levels = c("2", "1"))
main_df1$education <-factor(main_df1$education,levels = c("1", "2"))
main_df1$age <-factor(main_df1$age,levels = c("1", "2"))  
 
#using linear regression model
# refer to table 4, user attribute analysis
model <- lm(accuracy~ gender+age+education+phish_know+computer_know+security_know+duration, data = main_df1)

print(summary(model))

trust_sum <- summary(model)


