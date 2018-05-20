url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"./data/file.zip",method = "curl")
project <- unzip("./data/file.zip")
project <- read.table("./data/household_power_consumption.txt",header = T, sep = ";",na.strings = "?")

## subset date 1/2/2007 and 2/2/2007
data1 <- subset(project, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data1$Date),data1$Time)
data1$datetime <- as.POSIXct(datetime)

with(data1, {
    plot(Global_active_power~datetime, type="l",
   ylab="Global Active Power (kilowatts)", xlab="")
 })

##save to plot2.png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
