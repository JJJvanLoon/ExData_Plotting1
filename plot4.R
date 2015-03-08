## R script for plot 4 for a project
## Exploratory Data Analyisis

## checks if the file/object exists and downloads + creates if needed. 
if (!file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method = "curl",quiet = TRUE)
        unzip("household_power_consumption.zip")
        print("file created")
}
if (!exists("datahpc")) {
        print("Object does not exist, this could take a while")
        print("(this is a good time for coffee)") ## i like coffee
        datahpc <- read.csv2("household_power_consumption.txt", nrows = 2075259, na.strings="?", stringsAsFactors=FALSE)
        datahpc$Date <- as.Date(datahpc$Date, "%d/%m/%Y")
        datahpc$DateTime <- strptime(paste(datahpc$Date,datahpc$Time),"%Y-%m-%d %H:%M:%S")
        datahpc <- datahpc[(datahpc$Date == "2007-02-01" | datahpc$Date == "2007-02-02"),]
        print("Object created")
} else {
        ## reports back if object already exists. Does not check if the existing object is the correct object, to allow for revised files. 
        print("Object exists, time is saved!")
}
## initiates the png file
png("plot4.png")
##create plot
par(mfcol=c(2,2))
plot(datahpc$DateTime , as.numeric(datahpc$Global_active_power), type = "l", xlab = "", ylab = "Global Active Power")

plot(datahpc$DateTime, as.numeric(datahpc$Sub_metering_1), type = "l", xlab = "", ylab = "Energy sub metering")
lines(datahpc$DateTime, as.numeric(datahpc$Sub_metering_2), col = "red")
lines(datahpc$DateTime, as.numeric(datahpc$Sub_metering_3), col = "blue")
legend("topright", lty = 1, bty = "n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"))

plot(datahpc$DateTime, as.numeric(datahpc$Voltage), type = "l", xlab = "datetime", ylab = "Voltage")

plot(datahpc$DateTime, as.numeric(datahpc$Global_reactive_power), type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off() ## closes grapic device
if (file.exists("plot4.png")){
        print("Plot 4 produced")
}