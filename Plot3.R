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


#SUMMARISE DATA FOR CHART
BaltimoreNEI <- subset(NEI, NEI$fips == "24510")

BaltimoreEmissionType <- aggregate(Emissions ~ year + type, BaltimoreNEI, sum) 

#PLOT CHART
png("Plot3.png", width = 480, height = 480)

Plot3 <- ggplot(BaltimoreEmissionType, aes(year, Emissions, color = type, label = round(Emissions,2)))
Plot3 + geom_line() + geom_point(aes(color = type), show.legend = TRUE) 
      +xlab("Year")
      + ylab(expression("Total PM"[2.5]*" Emissions (tonnes)"))
      +ggtitle("Total Emissions by Emission Type", subtitle = "Baltimore")


    dev.off()