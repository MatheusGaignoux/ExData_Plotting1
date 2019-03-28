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

png("plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))

#plot 1

plot(datatime
     , data$Global_active_power
     , type = "l"
     , xlab = ""
     , ylab = "Global Active Power"
     )

#plot 2

plot(datatime, data[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub meteirng")
lines(datatime, data[, Sub_metering_2], col = "red")
lines(datatime, data[, Sub_metering_3], col = "blue")
legend("topright"
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col = c("black", "red", "blue")
       , lty = c(1,1,1)
       , bty = "n"
       , cex = .5
       )

#plot 3

plot(datatime, data[, Voltage]
     , type = "l"
     , xlab = "datatime"
     , ylab = "voltage"
     )

#plot 4

plot(datatime, data[, Global_reactive_power]
     , type = "l"
     , xlab = "datatime"
     , ylab = "Global_reactive_power"
     )

dev.off()
