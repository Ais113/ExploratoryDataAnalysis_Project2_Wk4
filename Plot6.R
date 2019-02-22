#EXPLORATORY DATA ANALYSIS: COURSE PROJECT 2

#Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health.
#In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for 
#fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its 
#database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). 
#You can read more information about the NEI at the EPA National Emissions Inventory web site.

#For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course
#of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.
#
# INSTALL REQUIRED PACKAGES & CALL LIBRARIES and SET WORKING DIRECTORY

#SET WORKING DIRECTORY HERE; THIS IS WHERE THE .RDS FILES SHOULD BE DOWNLOADED TO FROM
# DOWNLOAD DATA FROM LINK
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# UNZIP AND PLACE summarySCC_PM25.rds & Source_Classification_Code.rds IN THE WORKING DIRECTORY
setwd("F:/R Training/Course 4 - Exploratory Data Analysis/Week 4 Project")

#READ IN DATA
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#head(NEI)
#head(SCC)

#RUN REQUIRED LIBRARIES
#GGPLOT & GGREPEL USED
#install.packages("devtools")
library(devtools)

#install.packages("ggrepel") #FOR LABELS
library(ggrepel)
library(ggplot2)
library(plyr)
library(dplyr)



#Separate out the data relating to Motor and Baltimore
Motor_Baltm_LA_NEI <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")

#create a County Label to distinguish between LA and Baltimore
Motor_Baltm_LA_NEI$county <- ifelse(Motor_Baltm_LA_NEI$fips == "24510", "Baltimore, MD", "Los Angeles, CA")

#summarise the Motor related emissions for Baltimore and LA
Motor_Baltm_LA_Sum <- aggregate(Emissions ~ year + county, Motor_Baltm_LA_NEI, sum)

#PLOT CHART
png("Plot6.png", width = 800, height = 600)

Plot6 <- ggplot(Motor_Baltm_LA_Sum, aes(factor(year), Emissions, group = county, color = county, label = round(Emissions,2)))
Plot6 + geom_line()
      +geom_point(aes(color = county), pch = 15, show.legend = T)
      +xlab("Year")+ ylab(expression("Total PM"[2.5]*" Emissions (tons)"))
      +ggtitle("Comparison of Emissions by Year for Motor Vehicle Sources", subtitle = "Baltimore vs Los Angeles")
      +geom_label_repel(aes(label=round(Emissions,2)), box.padding = 0.35, point.padding = 0.5, label.size = 0.1, show.legend = F)


    dev.off()