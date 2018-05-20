url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"./data/file.zip",method = "curl")
project <- unzip("./data/file.zip")
project <- read.table("./data/household_power_consumption.txt",header = T, sep = ";",na.strings = "?")

## subset date 1/2/2007 and 2/2/2007
data1 <- subset(project, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$datetime <- as.POSIXct(datetime)

##graph the energy sub metering according to datetime
with(data1, 
     {plot(Sub_metering_2~datetime,col = "red",ylab = "Energy sub metering",xlab = "", type = "l", ylim = c(0,40))
       lines(Sub_metering_1~datetime,col = "black")
       lines(Sub_metering_3~datetime,col = "blue") })
legend("topright", col =c("black","red","blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex = 0.75)

## save the graph to plot3.png
dev.copy(png,file = "plot3.png",height = 480, width = 480)
dev.off()
