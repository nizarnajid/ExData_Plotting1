
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


#plotting into a png file
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()  



