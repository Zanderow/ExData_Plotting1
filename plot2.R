library(dplyr)
library(ggplot2)
library(gridExtra)

#Loading the data
dir <- 'D:/Wisdom/Education/1. Academic-Related/Coursera/Data Science/Quiz dataset'
data <- read.delim(file.path(dir, 'household_power_consumption.txt'),
                   header = TRUE, sep= ';')
data <- data %>% filter(Date == c('1/2/2007', '2/2/2007'))
data$Time <- paste(data$Date, data$Time)
data$Date <- as.Date(data$Date, format= '%d/%m/%Y')
data$Time <- strptime(data$Time, format= '%d/%m/%Y %H:%M:%S')
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Voltage <- as.numeric(data$Voltage)
data$Time <- as.POSIXct(data$Time)


dev.new()

#Plot 2
ggplot(data, aes(x=Time, y=Global_active_power)) +
  geom_line() +
  scale_x_datetime(date_breaks = '1 day', date_labels = "%a")