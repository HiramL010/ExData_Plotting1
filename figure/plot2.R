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


data2$Global_active_power <- as.numeric(data2$Global_active_power)

plot(data2$Date_Time, data2$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png", units = "px", width = 480, height = 480 )
dev.off()