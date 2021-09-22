library(stringr)
library(lubridate)

directory <- "./exdata_data_household_power_consumption/household_power_consumption.txt"

n_begin <- 66637 # the first value of 01/02/2007
n_end <- 69516 # the last value of 02/02/2007

data <- read.table(directory, header = TRUE, sep = ";")

data2 <- data[n_begin:n_end, ]

# creating a date/time class
data2$Date_Time <- paste(dmy(data2$Date),data2$Time)
data2$Date_Time <- strptime(data2$Date_Time, format="%Y-%m-%d %H:%M:%S" )

data2$Sub_metering_1 <- as.numeric(data2$Sub_metering_1)
data2$Sub_metering_2 <- as.numeric(data2$Sub_metering_2)
data2$Sub_metering_3 <- as.numeric(data2$Sub_metering_3)
data2$Global_active_power <- as.numeric(data2$Global_active_power)
data2$Voltage <- as.numeric(data2$Voltage)
data2$Global_reactive_power <- as.numeric(data2$Global_reactive_power)

png(file = "plot4.png", units = "px", width = 480, height = 480 )

par(mfrow= c(2,2), mar = c(4,4,2,2))
# first plot
plot(data2$Date_Time, data2$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")
# second plot
plot(data2$Date_Time, data2$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")
# third plot
plot(data2$Date_Time, data2$Sub_metering_1, type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(data2$Date_Time, data2$Sub_metering_2, type = "l", col = "red")
lines(data2$Date_Time, data2$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2",
                                       "Sub_metering_3"), 
       col = c("black", "red", "blue"), xpd=TRUE, cex = 1, x.intersp = 0.5)
# forth plot
plot(data2$Date_Time, data2$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()