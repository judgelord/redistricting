m <- members %>% group_by(pattern) %>% 
  mutate(congresses = str_c(congress %>% unique() %>% sort(), collapse = ";"))

m %<>% select(congresses, state, bioname, seo_name, 
              first_name, common_name, middle_name, maiden_name, last_name, add_last_name, 
              pattern) %>% distinct()


m %<>% arrange(bioname)

fix <- . %>% replace_na("")

m %<>% mutate_all(fix)

m$congresses %>% head()
m 
write_csv(m,"member_names.csv")

library(googlesheets4)
library(googledrive)

ss <- drive_get("member_names")
ss
sheet_write(data = m, ss =  ss, sheet = Sys.Date() %>%  as.character())

# TODO integrate sheet + updated voteview pull
# split nameCongres into two parts 
# one script to process voteview
# + one to create regex pattern to be used after integrating google sheet