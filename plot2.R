library("data.table")

setwd("~/")

if (!file.exists("Exploratory Base Graphs")){
  
  dir.create("Exploratory Base Graphs")
  
}

setwd("Exploratory Base Graphs")

if(!file.exists("household_power_consumption.zip")){
  
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                , destfile = "household_power_consumption.zip"
  )
  
}

unzip(zipfile = "household_power_consumption.zip")

data <- data.table::fread("household_power_consumption.txt", na.strings = "?")

data <- data[Date == "1/2/2007"| Date == "2/2/2007"]

Date <- as.Date(data$Date, format = "%d/%m/%Y")

datatime  <- strptime(paste(Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

png("plot2.png")

plot(datatime
     , data$Global_active_power
     , type = "l"
     , xlab = ""
     , ylab = "Global Active Power (kilowatts)"
     )

dev.off()
