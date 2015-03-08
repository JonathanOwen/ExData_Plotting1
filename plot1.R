## exdata-012 Exploratory Data Analysis
## Johns Hopkins Bloomberg School of Public Health
## Roger D. Peng (instructor)

## Course Project 1, Plot 1

## Jonathan Owen

## Data are from UCI Machine Learning Repository
## http://archive.ics.uci.edu/ml/

## zipped dataset is at
## https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip
## or
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## Description of the dataset is at 
## https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption



## Assumes dataset has been downloaded and extracted to
## "household_power_consumption" sub-directory under home directory 
setwd("household_power_consumption")

## Read data with no. of rows, column classes, and missing value characters 
## based on dataset description
classes <- c(rep("character",2),rep("numeric",7))
hpcdata <- read.table("household_power_consumption.txt",
                      sep = ";", colClasses = classes, na.strings = "?", 
                      header = TRUE, nrow = 2100000)

## Convert Date from character to date
hpcdata$Date <- as.Date(hpcdata$Date, "%d/%m/%Y")

## Combine date and time then convert to POSIXlt
hpcdata$Time <- paste(hpcdata$Date,hpcdata$Time)
hpcdata$Time <- strptime(hpcdata$Time, "%F %T")

## Select data from Feb 1-2, 2007 for plot
hpcforplot <- hpcdata[hpcdata$Date == "2007-02-01" |
                              hpcdata$Date == "2007-02-02",]

## Open png device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## Set plot layout
par(mfcol = c(1,1),             # single plot
    xaxs = "r",                 # regular axis style: extends data range by 4%
    yaxs = "r",          
    mar = c(5, 4, 4, 2) + 0.1)  # default margins

## Set fonts
par(font.axis = 1, family = "sans")

## Plot 1 is a histogram of Global Active Power
hist(hpcforplot$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power",
     col = "firebrick2")

dev.off()


