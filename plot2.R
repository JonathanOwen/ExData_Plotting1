## exdata-012 Exploratory Data Analysis
## Johns Hopkins Bloomberg School of Public Health
## Roger D. Peng (instructor)

## Course Project 1, Plot 2

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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

## Set plot layout
par(mfcol = c(1,1),             # single plot
    xaxs = "r",                 # regular axis style: extends data range by 4%
    yaxs = "r",          
    mar = c(5, 4, 4, 2) + 0.1)  # default margins

## Set fonts
par(font.axis = 1, family = "sans")

## Plot 2 is a line plot of Global Active Power against Time
plot(hpcforplot$Time, hpcforplot$Global_active_power, type = "l",
     ylab = "Global Average Power (kilowatts)",
     xlab = NA)

## Draw grey box around plot
box(which = "plot", col = "grey50")

## Redraw axes in black
axis(1,                                            # bottom axis
     xaxp = c(as.POSIXct(min(hpcforplot$Time)),    # coerce Time to POSIXct
              as.POSIXct(max(hpcforplot$Time)),1), # for axis plot
     col = "black", 
     lwd = 1.5,                                    # make line heavier
     labels = FALSE,                               # suppress labels
     lwd.ticks = 0)                                # suppress ticks

axis(2,
     yaxp = c(0,6,1),
     col = "black", 
     lwd = 1.5,
     labels = FALSE, 
     lwd.ticks = 0)

## Close png device
dev.off()

