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

#---Making Plot 2------------------------------------------------------------------------------------------

# Construct plot 2 on Screen Device
plot(x = data$Time, y = data$Global_active_power, type="l",
     ylab = "Global Active Power (killowats)", xlab="")

# Save it to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(device = png, file = "plot2.png", width = 480, height = 480)

# Turn off Device
dev.off()
