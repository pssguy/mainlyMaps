# http://shootingtracker.com/wiki/Mass_Shootings_in_2015


output$killCalendar <- renderGvis({
 killings %>% 
    mutate(Casualties=Dead+Injured) %>% 
    group_by(Date) %>% 
    summarize(all=sum(Casualties)) %>% 
    
    gvisCalendar("Date","all", options=list(width=1000, title="Mass killings in USA 2013 - 1st October 2015"))
  
 
})