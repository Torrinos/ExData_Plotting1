library(data.table)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data<-data.table(read.table(unz(temp,"household_power_consumption.txt"),sep=';',header=TRUE,nrows=100000))
unlink(temp)

#reading data
data<-subset(data,data$Date %in% c("1/2/2007","2/2/2007"))
data$Date<- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

#plotting plot4 and saving
png(filename ="plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
#1 global active
with(data,plot(Date,Global_active_power,"l",main=NULL,xlab="",ylab="Global Active Power"))

#2 voltage
with(data,plot(Date,Voltage,"l",main=NULL,xlab="datetime",ylab="Voltage"))

#3 sub metering
with(data,plot(Date,Sub_metering_1,"l",main=NULL,xlab="",ylab="Energy sub metering"))
lines(data$Date,data$Sub_metering_2,col="red")
lines(data$Date,data$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))

#4 global reactive
with(data,plot(Date,Global_reactive_power,"l",main=NULL,xlab="datetime"))
dev.off