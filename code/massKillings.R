# http://shootingtracker.com/wiki/Mass_Shootings_in_2015


output$killCalendar <- renderGvis({
 killings %>% 
    mutate(Casualties=Dead+Injured) %>% 
    group_by(Date) %>% 
    summarize(all=sum(Casualties)) %>% 
    
    gvisCalendar("Date","all", options=list(width=1000, title="Mass killings in USA 2013 - 1st October 2015"))
  
 
})


output$killMonth <- renderPlot({
temp <- killings %>% 
  mutate(Casualties=Dead+Injured,monthOrder=month(Date,label=F)) %>% 
  group_by(monthOrder,Year) %>% 
  summarize(all=sum(Casualties)) %>% 
  ungroup()  

p <-temp %>% 
  ggplot(aes(x = monthOrder,y = all, fill=factor(Year)))+
  geom_bar(stat = "identity",position = "dodge",width = .7) +
  ylab("Casualties") +
  xlab("Month") +
  scale_x_continuous(breaks = c(1:12)) +
  scale_fill_manual(
    name = "Year",
    values = c("turquoise","yellow2","coral"),
    labels = c("2013", "2014","2015")
  ) +
  theme_bw()
p
})

