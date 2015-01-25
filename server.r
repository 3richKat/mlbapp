ibrary(shiny)
setwd("~/Documents/Erich/R")
library(dplyr)
library(reshape2)
library(ggplot2)

data <- read.csv("mlb0914.csv")

#Adjust names
labs <- names(data)
names(data) <- c(labs[1:9],"BBpct", "Kpct",labs[12:17], "wRCplus", labs[19:23])

#Adjust BB% and K% to numeric
data$BBpct <- gsub(" %", "", data$BBpct)
data$BBpct <- as.numeric(paste(data$BBpct))/100
data$Kpct <- gsub(" %", "", data$Kpct)
data$Kpct <- as.numeric(paste(data$Kpct))/100



#Arrange data for Season vs Season comparions by player (also removing Team variable)
melt.data <- melt(data[,c(1:2,4:23)], id.vars=c("playerid","Name", "Season"))
seasons <- dcast(melt.data, playerid + Name + variable ~ Season)

##Create two season pair data frame
names <- c("playerid", "Name", "variable", "x", "y")
season.pairs <- rbind(setNames(seasons[1:5], names),
                      setNames(seasons[c(1:3,5:6)], names),
                      setNames(seasons[c(1:3,6:7)], names),
                      setNames(seasons[c(1:3,7:8)], names),
                      setNames(seasons[c(1:3,8:9)], names))
season.pairs <- season.pairs[which(complete.cases(season.pairs) ==T),]  #Remove NAs
stats <- levels(season.pairs$variable)
cortable <- summarize(group_by(season.pairs, variable), cor(x,y)) 
names(cortable) <- c("variable", "cor")

shinyServer(
  function(input,output) {
    
    output$table <- renderTable({as.data.frame(cortable)})
    
    output$graph <- renderPlot({
      ggplot(data=filter(season.pairs, variable == input$stat), aes(x, y) ) + 
      geom_point(alpha=.4) + geom_smooth(method="lm") + 
      labs(x="Year 1", y="Year 2", title="Year over Year Correlation") 
      
    })
    
    
  })
