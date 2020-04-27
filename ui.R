ui <- fluidPage(
  
  # Layout and menu items 
  
  dashboardPage(
      skin = 'purple',   
      dashboardHeader(title = "Video Game Sales"),
      dashboardSidebar(
        sidebarUserPanel(name = "Chase Rendall"),
        sidebarMenu(id = 'sidebarmenu',
                    menuItem("Home", tabName = "home", icon = icon("star")),
                    menuItem("Overview", tabName = "overview", icon = icon("bar-chart-o")),
                    menuItem("Revenue", tabName = "revenue_tab", icon = icon("dollar")),
                    menuItem("Region", tabName = 'region', icon = icon("fas fa-globe")),
                    menuItem("Top 10", tabName = "top10", icon = icon("list-alt")),
                    menuItem("Boxplot", tabName = "boxplot", icon = icon("fas fa-box")),
                    menuItem("About", tabName = "about", icon = icon("fas fa-info"))
        )
      ),
      
      dashboardBody(
        tabItems(
          
          # Home  ##############################################################################
          
          tabItem(
            tabName = 'home', h1('Global Video Game Sales from 1980-2016'),
            fluidRow(
              box(
                outputId = 'home1',
                width = 12,
                h4(textOutput('home1'))),
              box(
                outputId = 'home2',
                width = 12,
                h4(textOutput('home2'))),
              box(
                outputId = 'home3',
                width = 12,
                h4(textOutput('home3')))
            ),
            fluidRow(
              img(src = 'videogames.jpg', width = '100%')
            )
          ),
          
         # # Overview ########################################################################## 
           
           tabItem(
             tabName = 'overview', h1('Overview of Data by Year'),
             fluidRow(
               box(width = 3, 
                  selectInput("category_0", label = h3("Select a Category:"),
                              choices = c("Name", "Revenue"),
                              selected = "Name")
               ),
               box(
                 plotOutput('ggplot_bar', width = "150%")
               )
             )
           ),
              
           
        
          
          # Revenue ###########################################################################
         
         tabItem(
           tabName = 'revenue_tab', h3("Categories by Revenue per Year"),
           fluidRow(
             box(width = 3,
               selectInput("category_1", label = h3("Select a Category:"), 
                           choices = c("Publisher", "Genre", "Name", "Platform"), 
                           selected = "Publisher")
             ),
             box(
               plotOutput('ggplot1_bar', width = "150%")
               #textOutput('home1')
             )
           )
         ),
         
        # Region ############################################################################
        
        tabItem(
          tabName = "region", h3("Top 3 by Revenue per Region"),
          fluidRow(
            box(width = 3,
               selectizeInput("category_2", "Select a Category:",
                            choices = c("Publisher", "Name", "Genre", "Year", "Platform"),
                            selected = "Publisher")
               ),
            box(
              plotOutput('ggplot2_bar')
            )
          )
        ),
  
          # Top 10 ############################################################################
  
         tabItem(
           tabName = "top10", h3("Top 10 by Revenue"),
           fluidRow(
             box(width = 6,
                selectizeInput("category_3", "Select a Category:",
                             choices = c("Publisher", "Name", "Platform"),
                             selected = "Publisher")
                ),
             box(
               plotOutput('ggplot3_bar')
             )
           )
         ),
        
         # Boxplot ############################################################################
        
         tabItem(
           tabName = "boxplot", h3("Boxplots of Sales Statistics"),
           fluidRow(
             box(width = 6,
                selectizeInput("category_4", "Select a Category:",
                              choices = c("Region", "Year"),
                              selected = "Region")
                ),
             box(
               plotOutput('ggplot4_box')
             )
           )
         ),
          
        # About #################################################################################
        
        tabItem(
          tabName = 'about', h1('About this App'),
          fluidRow(
            box(
              outputId = 'about1',
              width = 12,
              h4(textOutput('about1'))),
            box(
              outputId = 'about2',
              width = 12,
              h4(textOutput('about2'))),
            box(
              outputId = 'about3',
              width = 12,
              h4(textOutput('about3')))
          )
        )
  
        ########################################################################################       
                
      )
    )
  )
)




