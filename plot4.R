library(data.table)
#---Loading the data---------------------------------------------------------------------------------------
# Loading the data 

# Load raw data by read.table function with seperate char = ";" and convert "?" value into "NA" as remined 
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Convert Date factor into Date class 
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Convert Time factor into POSIXlt class
data$Time <- strptime(paste(data$Date, data$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")

# Just keep data from the dates 2007-02-01 and 2007-02-02 for better performance when plotting
data<-data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]

#---Making Plot 4------------------------------------------------------------------------------------------

# Open png device with new file name "plot4.png"
png(file = "plot4.png", width = 480, height = 480)

# Define multiplot layout
par(mfrow = c(2, 2), mar = c(6, 4, 2, 1))

with(data, {
  
  # Draw "Global Active Power" plot
  plot(x = Time, y = Global_active_power, type= "l", ylab = "Global Active Power", xlab = "")
  
  # Draw "Voltage" plot
  plot(x = Time, y = Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

  # Draw "Energy sub metering" plot
  plot(x = data$Time, y = data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(x = data$Time, y = data$Sub_metering_2, type = "l", col = "red")
    lines(x = data$Time, y = data$Sub_metering_3, type = "l", col = "blue")
    legend("topright",legend = tail(names(data),3), col = c("black","red","blue"), lty = 1, lwd = 2, bty = "n")
  
  # Draw "Global_reactive_power" plot
  plot(x = Time, y = Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
 
})

# Turn off Device
dev.off()
