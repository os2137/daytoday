
library(tidyverse)

grants <- readxl::read_excel("live_grants.xlsx", sheet = "all_grants") %>% 
  janitor::clean_names()


 
  bind_cols(grants %>%
    select(friendly_name, grant_status),
   grants %>% 
  select_if(is.numeric)) %>% 
    group_by(friendly_name, grant_status) %>% 
    summarize(across(where(is.numeric), fns = sum, na.rm = T)) %>% 
    ungroup() %>% 
    rowwise() %>% 
    mutate(target_minus_actual = target_cash_amount_amount - actual_cash_amount_amount)  %>% 
    filter(target_minus_actual != 0) %>% 
  select(1:4, target_minus_actual) %>%  View()
           
  

