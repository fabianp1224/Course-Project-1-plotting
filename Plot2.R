library(tidyverse)


#download Data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep = ";",header = TRUE)
unlink(temp)




data$Date <- as.Date(data$Date,"%d/%m/%Y")

data <- data %>% filter(Date >= as.Date(c("2007-02-01"),"%Y-%m-%d") & Date<= as.Date(c("2007-02-02"),"%Y-%m-%d"))


data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity  <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

data$Global_active_power[is.na(data$Global_active_power)] <- 0
data <- data %>% mutate(fecha = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))


##plot 2

png(filename =  "Plot2.png",width = 480, height = 480)
plot(data$Global_active_power~data$fecha,type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

