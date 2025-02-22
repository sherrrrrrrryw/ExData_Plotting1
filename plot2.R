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

### Plot2
#Set the locale to English
Sys.setlocale("LC_TIME", "C")

# Plot the data as a line plot using DateTime on the X-axis (xaxt="n" disables the default X-axis labels)
plot(HPCdata$Global_active_power~HPCdata$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")

# Select a subset of DateTime for positioning the axis labels (every 1440th point)
axis_ticks <- seq(1, length(HPCdata$DateTime), by=1440)

# Create the day labels for the selected ticks
day_labels <- format(HPCdata$DateTime[axis_ticks], "%a")

# Add the custom X-axis with day labels
axis(1, at=HPCdata$DateTime[axis_ticks], labels=day_labels)

# Add "Sat" label to the X-axis even if it's not in the dataset
axis(1, at=HPCdata$DateTime[nrow(HPCdata)], labels = "Sat")

# Save plot1 as png file
dev.copy(png, "plot2.png",width = 480, height = 480)
dev.off()
