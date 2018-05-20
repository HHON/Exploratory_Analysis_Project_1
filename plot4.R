url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"./data/file.zip",method = "curl")
project <- unzip("./data/file.zip")
project <- read.table("./data/household_power_consumption.txt",header = T, sep = ";",na.strings = "?")

## subset date 1/2/2007 and 2/2/2007
data1 <- subset(project, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$datetime <- as.POSIXct(datetime)

## graphing
par(mfrow = c(2,2), mar = c(4,4,2,1),oma = c(0,0,2,1))
with(data1, plot(Global_active_power~datetime, type = "l", ylab = "Global Active Power",xlab = ""))
with(data1, plot(Voltage~datetime, type = "l", ylab = "Voltage"))
with(data1, 
     {plot(Sub_metering_2~datetime,col = "red",ylab = "Energy sub metering",xlab = "", type = "l", ylim = c(0,40))
       lines(Sub_metering_1~datetime,col = "black")
       lines(Sub_metering_3~datetime,col = "blue") })
legend("topright", col =c("black","red","blue"), lty = 1, lwd = 2, bty = "n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex = 0.3)
with(data1, plot(Global_reactive_power~datetime, type = "l", ylab = "Global_reactive_power"))

## save it to png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
