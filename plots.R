library(tidyverse)
vgsales <- read.csv('./vgsales.csv', stringsAsFactors = FALSE)


#Clean the data by removing years beyond 1980-2016.  This includes "N/A", "2017", and "2020".  
vgsales <- filter(vgsales, Year != 'N/A' & Year != '2017' & Year != '2020')


#Video game releases by year 
ggplot(vgsales, aes(x = Year)) + 
  geom_bar(fill = "skyblue2") + 
  ggtitle("Games Released by Year")

#Total video game revenue per year 
total_rev_per_year <- vgsales %>% 
  group_by(Year) %>% 
  summarise(Revenue = sum(Global_Sales))

ggplot(total_rev_per_year, aes(x = Year, y = Revenue)) + 
  geom_bar(fill = "royalblue2", stat = "identity") + 
  ggtitle("Total Sales Revenue by Year")

#Top publisher by revenue per year
top_pub_rev_year <- vgsales %>% 
  group_by(Year, Publisher) %>% 
  summarise(Revenue = sum(Global_Sales)) %>%
  top_n(1)                              
  
ggplot(top_pub_rev_year, aes(x = Year, y = Revenue, fill = Publisher)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Top Publisher by Revenue per Year")

#Top genre by revenue per year
top_genre_rev_year <- vgsales %>% 
  group_by(Year, Genre) %>%
  summarise(Revenue = sum(Global_Sales)) %>%
  top_n(1)

ggplot(top_genre_rev_year, aes(x = Year, y = Revenue, fill = Genre)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Top Genre by Revenue per Year")

#Top games by revenue per year
top_games_rev_year <- vgsales %>%
  group_by(Year, Name) %>%
  summarise(Revenue = sum(Global_Sales)) %>%
  top_n(1)

ggplot(top_games_rev_year, aes(x = Year, y = Revenue, fill = Name)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Top Game by Revenue per Year")

#Top platform by revenue per year
top_platform_rev_year <- vgsales %>%
  group_by(Year, Platform) %>%
  summarise(Revenue = sum(Global_Sales)) %>%
  top_n(1)

ggplot(top_platform_rev_year, aes(x = Year, y = Revenue, fill = Platform)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Top Platform by Revenue per Year")

#Top publishers by total revenue
top_pub_total_rev <- vgsales %>%
  group_by(Publisher) %>%
  summarise(Revenue = sum(Global_Sales), Percentage = (Revenue / sum(vgsales$Global_Sales) * 100)) %>%
  arrange(desc(Revenue)) %>%
  head(10)

ggplot(top_pub_total_rev, aes(x = Year, y = Revenue, fill = Publisher)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Top 10 Publishers by Revenue") 

#Genre by releases per year
genre_releases_per_year <- vgsales %>%
  group_by(Genre) %>%
  summarise(Total = n(), Percentage = (Total / length(vgsales)) * 100) %>%
  arrange(desc(Percentage))

ggplot(genre_releases_per_year, aes(x = Genre, y = Total, fill = Genre)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Genre by Number of Releases per Year")
  
#Top 5 platforms by revenue per region
  top_platform_rev_region <- vgsales %>%
    group_by(Region, Platform) %>%
    summarise(Revenue = sum(Revenue)) %>%
    arrange(desc(Revenue)) %>%
    top_n(5)
  
#Top 10 games by revenue 
  top_10_by_rev <- vgsales %>%
    group_by(Name) %>%
    summarise(Revenue = sum(Global_Sales), Percentage = Revenue / sum(vgsales$Global_Sales) * 100) %>%
    arrange(desc(Revenue)) %>%
    head(10)

ggplot(top_10_by_rev, aes(reorder(Name, Revenue),  Revenue, fill = Name)) +
  ggtitle("Top 10 Games by Revenue") + 
  xlab("Games") + 
  ylab("Revenue (millions)") + 
  coord_flip()

#Top 3 publishers by revenue in each region
top_pub_region <- vgsales %>%
  group_by(Region, Publisher) %>%
  summarise(Revenue = sum(Revenue)) %>%
  arrange(desc(Revenue)) %>%
  top_n(3)

ggplot(top_pub_region, aes(x = Region, y = Revenue, fill = Publisher)) +
  geom_bar(position = "dodge", stat = "identity") + 
  ggtitle("Top 3 Publishers by Revenue per Region") + 
  ylab("Revenue (millions)") + 
  xlab("Region")  

#Top 3 games by revenue in each region
top_games_region <- vgsales %>%
  group_by(Region, Name) %>%
  summarise(Revenue = sum(Revenue)) %>%
  arrange(desc(Revenue)) %>%
  top_n(3)

ggplot(top_games_region, aes(x = Region, y = Revenue, fill = Name)) +
  geom_bar(position = "dodge", stat = "identity") + 
  ggtitle("Top 3 Games by Revenue per Region") + 
  ylab("Revenue (millions)") + 
  xlab("Region")

#Top 3 genres by revenue in each region
top_genre_region <- vgsales %>%
  group_by(Region, Genre) %>%
  summarize(Revenue = sum(Revenue)) %>%
  arrange(desc(Revenue)) %>%
  top_n(3)

ggplot(top_genre_region, aes(x = Region, y = Revenue, fill = Genre)) + 
  geom_bar(position = "dodge", stat = "identity")  +
  ggtitle("Top 3 Genres by Revenue per Region") +
  ylab("Revenue (millions)") +
  xlab("Region") 

#Top 3 years by revenue in each region
top_year_region <- vgsales %>%
  group_by(Region, Year) %>%
  summarize(Revenue = sum(Revenue)) %>%
  arrange(desc(Revenue)) %>%
  top_n(3)

ggplot(top_year_region, aes(x = Region, y = Revenue, fill = Year)) + 
  geom_bar(position = "dodge", stat = "identity")  +
  ggtitle("Top 3 Years by Revenue per Region") +
  ylab("Revenue (millions)") +
  xlab("Region")

#Top 3 platforms by revenue in each region
top_plat_region <- vgsales %>%
  group_by(Region, Platform) %>%
  summarise(Revenue = sum(Revenue)) %>%
  arrange(desc(Revenue)) %>%
  top_n(3)

ggplot(top_plat_region, aes(x = Region, y = Revenue, fill = Platform)) + 
  geom_bar(position = "dodge", stat = "identity") + 
  ggtitle("Top 3 Platforms by Revenue per Region") + 
  ylab("Revenue (millions)") + 
  xlab("Revenue (millions)")

#Boxplot of sales
ggplot(vgsales, aes(x = Region, y = Revenue, fill = Region)) + 
  geom_boxplot() +
  scale_y_log10() +
  ggtitle("Distribution of Sales Revenue") +
  coord_flip()

ggplot(vgsales, aes(x = Year, y = Revenue)) + 
  geom_boxplot(fill = "red1") +
  scale_y_log10() +
  ggtitle("Distribution of Sales Revenue - Year") +
  coord_flip()