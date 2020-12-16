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

#Plot 1
ggplot(data, aes(x= Global_active_power)) +
  geom_histogram(bins = 15, colour= 'black', fill='red') +
  labs(title= 'Global Active Power') +
  xlab('Global Active Power (kilowatts)') + ylab('Frequency')

#Plot 2
ggplot(data, aes(x=Time, y=Global_active_power)) +
  geom_line() +
  scale_x_datetime(date_breaks = '1 day', date_labels = "%a")

#Plot 3 
ggplot(data, aes(x=Time)) +
  geom_line(aes(y= Sub_metering_1, color= 'Sub_metering_1')) +
  geom_line(aes(y= Sub_metering_2, color= 'Sub_metering_2')) +
  geom_line(aes(y= Sub_metering_3, color= 'Sub_metering_3')) +
  scale_x_datetime(date_breaks = '1 day', date_labels = "%a") +
  scale_color_manual(values= c('black', 'red', 'blue')) +
  labs(color= '') + theme(legend.position = c(0.89,0.96), legend.key = element_rect(fill= 'transparent'))

#Plot 4
p1 <- ggplot(data, aes(x=Time, y=Global_active_power)) +
  geom_line() +
  scale_x_datetime(date_breaks = '1 day', date_labels = "%a")
p2 <- ggplot(data, aes(x=Time, y=Voltage)) +
  geom_line() +
  scale_x_datetime(date_breaks = '1 day', date_labels = "%a")                          
p3 <- ggplot(data, aes(x=Time)) +
  geom_line(aes(y= Sub_metering_1, color= 'Sub_metering_1')) +
  geom_line(aes(y= Sub_metering_2, color= 'Sub_metering_2')) +
  geom_line(aes(y= Sub_metering_3, color= 'Sub_metering_3')) +
  scale_x_datetime(date_breaks = '1 day', date_labels = "%a") +
  scale_color_manual(values= c('black', 'red', 'blue')) +
  labs(color= '') + theme(legend.position = c(0.80,0.91))
p4 <- ggplot(data, aes(x=Time, y=Global_reactive_power)) +
  geom_line() +
  scale_x_datetime(date_breaks = '1 day', date_labels = "%a")

grid.arrange(p1,p2,p3,p4,
             nrow= 2, ncol= 2)


