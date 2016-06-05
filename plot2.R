## --------------------------------------------------------------------------------------
## Exploratory Data Analysis
## Week 1
## Requires R 3.2.0
## B McLeod 5/6/2016
## --------------------------------------------------------------------------------------



## --------------------------------------------------------------------------------------
## Setup environment
## --------------------------------------------------------------------------------------


## Initial Variables common to many R scripts
workingDir <- "C:\\Users\\work\\Desktop\\DataScience\\WorkingDir\\"
assignmentDir <- "ExploratoryAnalysisWeek1"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "download.zip"
unzippedFile <- "household_power_consumption.txt"
outputFile <- "plot2.png"


## Create/Set Working Directory
if (file.exists(workingDir)){
    setwd(file.path(workingDir, assignmentDir))
} else {
    dir.create(file.path(workingDir, assignmentDir))
    setwd(file.path(workingDir, assignmentDir))
}



## --------------------------------------------------------------------------------------
## Source data
## --------------------------------------------------------------------------------------


## Download file/s from source in case content changes.  Bandwidth and storage are cheap.
download.file(fileUrl, destfile = downloadFile)


## Unzip file/s
unzip(downloadFile)



## --------------------------------------------------------------------------------------
## Ingest data
## --------------------------------------------------------------------------------------


## The data set is large so only load the first 2 days in February 2007.
## REGEX is used to identify the dates and grep to extract the data.
## We are told null values are shown as ?.
dataFile <- file("household_power_consumption.txt", "r")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(dataFile), value=TRUE), sep=";", na.strings="?")
unlink(downloadFile)


## Assign column names to reference the data
colnames(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")


## We are informed the date format is dd/mm/yyyy and time format is hh:mm:ss
## We can join the two together to form a Date Time field
DateTime <- paste (data$Date, data$Time)
data$DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")



## --------------------------------------------------------------------------------------
## Produce the desired output
## --------------------------------------------------------------------------------------


## Plot should be to the PNG graphics device, 480 pixels wide, 480 pixels high (default).
png(file=outputFile)
with(data, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
