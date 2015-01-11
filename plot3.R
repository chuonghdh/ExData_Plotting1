library(data.table)
#---Loading the data---------------------------------------------------------------------------------------
# Loading the data 

# Load raw data by read.table function with seperate char = ";" and convert "?" value into "NA" as remined 
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Convert Date factor into Date class 
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Convert Time factor into POSIXlt class
data$Time <- strptime(paste(data$Date, data$Time, sep=" "), format = "%Y-%m-%d %H:%M:%S")

# Just keep data from the dates 2007-02-01 and 2007-02-02 for better performance when plotting
data<-data[(data$Date == "2007-02-01"|data$Date == "2007-02-02"), ]

#---Making Plot 3------------------------------------------------------------------------------------------

#open png device with new file name "plot3.png"
png(file="plot3.png",width = 480, height = 480)

# Construct plot 3 on png device with 1st line for Sub_metering_1 series
plot(x = data$Time, y = data$Sub_metering_1, type = "l", ylab ="Energy sub metering", xlab="")

# Draw 2nd line for Sub_metering_2 series
lines(x = data$Time, y = data$Sub_metering_2, type= "l", col="red")

# Draw 3rd line for Sub_metering_3 series
lines(x = data$Time, y = data$Sub_metering_3, type= "l", col="blue")

# Add legend to plot
legend("topright",legend = tail(names(data),3), col=c("black","red","blue"), lty=1, lwd=2)

# Turn off Device
dev.off()
