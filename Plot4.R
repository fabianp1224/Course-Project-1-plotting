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


##plot 4

png(filename =  "Plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
plot(data$Global_active_power~data$fecha,type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(data$Voltage~data$fecha,type="l", xlab="", ylab="Voltage")
plot(data$Sub_metering_1~data$fecha,type="l", xlab="", ylab="Global Active Power (kilowatts)")
points(data$Sub_metering_2~data$fecha,type="l",col="red")
points(data$Sub_metering_3~data$fecha,type="l",col="blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(data$Global_reactive_power~data$fecha,type="l", xlab="", ylab="Global Reactive Power (kilowatts)")
par(mfrow=c(1,1))

dev.off()