url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"./data/file.zip",method = "curl")
project <- unzip("./data/file.zip")
project <- read.table("./data/household_power_consumption.txt",header = T, sep = ";",na.strings = "?")

## subset date 1/2/2007 and 2/2/2007
data1 <- subset(project, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")

## graph the histogram and save it to a png file
par(mfrow = c(1,1))
par(oma = c(1,1,1,1),mar = c(5,5,5,5))
hist(data1$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()


