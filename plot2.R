library(data.table)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data<-data.table(read.table(unz(temp,"household_power_consumption.txt"),sep=';',header=TRUE,nrows=100000))
unlink(temp)

#reading data
data<-subset(data,data$Date %in% c("1/2/2007","2/2/2007"))
data$Date<- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)

#plotting plot2 and saving
png(filename ="plot2.png", width = 480, height = 480)
with(data,plot(Date,Global_active_power,"l",main=NULL,xlab="",ylab="Global Active Power (kilowatts)"))
dev.off