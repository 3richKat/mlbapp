shinyUI(fluidPage(
  
  titlePanel("MLB Year over Year Offensive Statistical Correlation"),
  sidebarLayout(
    sidebarPanel(
      helpText("Select a statistic to view individual player performance 
               between two seasons"),
      
      selectInput("stat",
                  label = "Choose Statistic",
                  choices=c('G', 'PA', 'HR', 'R', 'RBI', 'SB', 'BBpct', 'Kpct',
                            'ISO', 'BABIP', 'AVG', 'OBP', 'SLG', 'wOBA', 
                            'wRCplus', 'BsR', "Off", "Def", "WAR"),
                  selected="OBP"), 
      helpText("Master Correlation Table for the given Offensive Statistics"),
      tableOutput("table")),
  mainPanel(plotOutput("graph"),
            helpText("We can see that context specific statistics (R, RBI)
                      and batted ball statistics (AVG, BABIP) are less predictive, 
                      year over year, than Plate Discipline stats (OBP, K%, BB%) and
                     Power stats (HR, ISO, SLG)"),
            a("*All Data courtesy of the amazing people at Fangraphs", href="http://www.fangraphs.com"),
            helpText("**Data is paired by batter for consecutive seasons"),
            helpText("***Only Qualifying seasons included (reached minimum AB threshold)"),
            a("****Glossary of Statistics Here", 
                     href="http://www.fangraphs.com/library/offense/offensive-statistics-list/")
            
            
))
))
