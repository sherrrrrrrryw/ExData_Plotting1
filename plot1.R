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

### Plot 1

# Create plot1
hist(HPCdata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Save plot1 as png file

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()