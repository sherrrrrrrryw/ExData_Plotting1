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

### Plot3
#Set the locale to English
Sys.setlocale("LC_TIME", "C")

# Create plot3
with(HPCdata,{
  plot(Sub_metering_1~DateTime, type = "l", col = "black", ylab = "Energy sub metering", xlab = "", xaxt = "n")
  lines(Sub_metering_2~DateTime, col = "red")
  lines(Sub_metering_3~DateTime, col = "blue")
})

# Select a subset of DateTime for positioning the axis labels (every 1440th point)
axis_ticks <- seq(1, length(HPCdata$DateTime), by = 1440)

# Create the day labels for the selected ticks
day_labels <- format(HPCdata$DateTime[axis_ticks], "%a")

# Add the custom labels to the x-axis
axis(1, at = HPCdata$DateTime[axis_ticks], labels = day_labels)

# Add "Sat" label manually even if it's not in the dataset
axis(1, at = HPCdata$DateTime[nrow(HPCdata)], labels = "Sat")

# Create the legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = c(1, 1, 1), cex = 1)

# Save the plot as png file
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()