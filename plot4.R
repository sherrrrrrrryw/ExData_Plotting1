getwd()
setwd("P://R/Coursera/Asn/Exploratory_data_analysis/wk1")

# Load the entire dataset
file <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))


#Subset the data from the dates 1/2/2007 and 2/2/2007
HPCdata <- subset(file, Date == "1/2/2007" | Date == "2/2/2007")


# Remove the data with the missing values
HPCdata <- HPCdata[complete.cases(HPCdata),]

# Combine Date & Time column
HPCdata$DateTime <- paste(HPCdata$Date, HPCdata$Time)


# Remove the Date column and the Time column
HPCdata <- HPCdata[ , !names(HPCdata) %in% c('Date', 'Time')]

# Convert DateTime column to date type
HPCdata$DateTime <- strptime(HPCdata$DateTime, format = "%d/%m/%Y %H:%M:%S")
HPCdata$DateTime <- as.POSIXct(HPCdata$DateTime)

### Plot4

# Create the plot frame
par(mfrow = c(2,2), mar = c(5,5,2,1), oma = c(1,0,1,0))

# Create axis ticks
axis_ticks <- seq(1, length(HPCdata$DateTime), by = 1440)

# Create the day labels for the selected ticks
day_labels <- format(HPCdata$DateTime[axis_ticks], "%a")

# Create plot4
with(HPCdata, {
  plot(Global_active_power~DateTime, type = "l", col = "black", xaxt = "n", ylab = "Global Active Power", xlab = "")
  axis(1, at = HPCdata$DateTime[axis_ticks], labels = day_labels)
  axis(1, at = HPCdata$DateTime[nrow(HPCdata)], labels = "Sat")
  plot(Voltage~DateTime, type = "l", col = "black", ylab = "Voltage", xlab = "datetime", xaxt = "n")
  axis(1, at = HPCdata$DateTime[axis_ticks], labels = day_labels)
  axis(1, at = HPCdata$DateTime[nrow(HPCdata)], labels = "Sat")
  plot(Sub_metering_1~DateTime, type = "l", col = "black", xlab = "", xaxt = "n", ylab = "Energy sub metering")
  lines(Sub_metering_2~DateTime, col = "red")
  lines(Sub_metering_3~DateTime, col = "blue")
  axis(1, at = HPCdata$DateTime[axis_ticks], labels = day_labels)
  axis(1, at = HPCdata$DateTime[nrow(HPCdata)], labels = "Sat")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = c(1,1,1), bty = "n", cex = 0.8)
  plot(Global_reactive_power~DateTime, type = "l", col = "black", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
  axis(1, at = HPCdata$DateTime[axis_ticks], labels = day_labels)
  axis(1, at = HPCdata$DateTime[nrow(HPCdata)], labels = "Sat")
})

# Save plot4 as png file
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()