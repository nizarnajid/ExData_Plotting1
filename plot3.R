
library(dplyr)

#---------------------------------------------------------------------------------------------------
#Donwloading zip file containing data and reading data

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "Dataset.zip"

if (!file.exists(zipFile)) {
        download.file(zipUrl, zipFile, mode = "wb")
}

# unzipping file if directory doesn't exist
dataPath <- "Dataset"
if (!file.exists(dataPath)) {
        unzip(zipFile)
}


#Reading file into a data frame
data <- read.table(file.path("household_power_consumption.txt"), sep = ";", header = TRUE, colClasses = rep("character",9))

data[data == "?"] <- NA

#formatting the date column
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#keeping only the relevant rows
data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

data$Global_active_power <- as.numeric(data$Global_active_power)

# Creating a posixct object
time <- paste(data$Time, data$Date, sep = " ")
data$realTime <- as.POSIXct(strptime(time, format = "%H:%M:%S %Y-%m-%d"))

#plotting into a png file
png(file = "plot3.png", width = 480, height = 480, units = "px")

plot(data$realTime, data$Sub_metering_1, ylab = "Energy sub metering", col = "black", type = "l")

points(data$realTime, data$Sub_metering_2, col = "red", type ="l")

points(data$realTime, data$Sub_metering_3, col = "blue", type ="l")

legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=1)

dev.off()  



