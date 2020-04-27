shinyServer(function(input, output) {
  
  # Home ###########################################################################################    
  output$home1 = renderText(
    'Hello! Welcome to my video game sales analysis app!'
  )
  output$home2 = renderText(
    'In this app, you can find information on video game sales greater than 100,000 copies sold
     from 1980-2016.  The dataset consists of over 11,000 records of various video game releases 
     across 31 platforms and 579 publishers.'
  )
  output$home3 = renderText(
    'For further information regarding the code or sources, please check the About page.'
  )
  
  # Overview ########################################################################################
  
  dataInput <- reactive({
    vgsales %>%
      select_('Year', 'Global_Sales', input$category_0) %>%
      group_by_('Year') %>%
      summarise(Revenue = sum(Global_Sales))
      
  })
  
  output$ggplot_bar <- renderPlot({
    data <- dataInput()
    
    data %>%
      ggplot(aes(x = Year, y = input$category_0)) +
      geom_bar(fill = "royalblue2", stat = "identity") + 
      ggtitle("Overview of Data by Year")
  })
  
  # Revenue #########################################################################################
  
   dataInput <- reactive({
     vgsales %>%
       select_('Year', 'Global_Sales', input$category_1) %>% 
       group_by_('Year', input$category_1) %>%
       summarise(Revenue = sum(Global_Sales)) %>%
       top_n(1)
   })
  
  output$ggplot1_bar <- renderPlot({
     data1 <- dataInput()
    
    data1 %>% 
       ggplot(aes(x = Year, y = Revenue)) +
       geom_bar(stat = "identity") +
       ggtitle("Top Categories by Revenue per Year") 
       
   })
  
# Region ##########################################################################################
  
  dataInput2 <- reactive({
    vgsales %>%
      select_('Region', 'Global_Sales', input$category_2) %>%
      group_by_('Region', input$category_2) %>%
      summarise(Revenue = sum(Global_Sales)) %>%
      top_n(3)
  })
  
  output$ggplot2_bar <- renderPlot({
    data2 <- dataInput2()
  
  
    data2 %>%
      ggplot(aes(x = Region, y = Revenue, fill = input$category_2)) + 
      geom_bar(position = "dodge", stat = "identity") + 
      ggtitle("Top 3 Categories by Revenue per Region")
    
})

# Top 10 ##########################################################################################
  
  dataInput3 <- reactive({
    vgsales %>%
      select(input$category_3, 'Global_Sales') %>%
      group_by_(input$category_3) %>%
      summarise(Revenue = sum(Global_Sales), Percentage = Revenue / sum(vgsales$Global_Sales) * 100) %>%
      arrange(desc(Revenue)) %>%
      head(10) 
 })
  
  output$ggplot3_bar <- renderPlot({
    data3 <- dataInput3()
    
    data3 %>%
      ggplot(aes(reorder(Name, Revenue),  Revenue, fill = input$category_3)) +
        geom_bar(stat = "identity") + 
        ggtitle("Top 10 by Revenue") + 
        xlab("Games") + 
        ylab("Revenue (millions)") + 
        coord_flip()
  })

# Boxplot #########################################################################################

  dataInput4 <- reactive({
    vgsales %>%
      select(Region, Revenue, input$category_4)
  })
  
  output$ggplot4_box <- renderPlot({
    data4 <- dataInput4()
    
    data4 %>%
      ggplot(vgsales, aes(x = Region, y = Revenue, fill = input$category_4)) + 
      geom_boxplot() +
      scale_y_log10() +
      ggtitle("Distribution of Sales Revenue by Region") +
      coord_flip()
  })
 
  # About ###########################################################################################

  output$about1 = renderText(
    'My name is Chase Rendall and I am currently a student in the Spring 2020 NYC Data Science Academy
     cohort.'
  )
  output$about2 = renderText(
    'This app provides sales data visualization covering video game releases from 1980-2016 
    across 31 major gaming platforms, 577 publishers, 12 genres, and four global regions.'
  )
  output$about3 = renderText(
    'The data for this app was scraped from vgchartz.com. and the associated Kaggle page:
     https://www.kaggle.com/gregorut/videogamesales'
    )
  
  
  ####################################################################################################
  
})