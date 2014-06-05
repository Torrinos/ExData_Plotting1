library(data.table)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data<-data.table(read.table(unz(temp,"household_power_consumption.txt"),sep=';',header=TRUE,nrows=100000))
unlink(temp)

#reading data
data$Date<-as.Date(strptime(data$Date,format="%d/%m/%Y"))
data$Global_active_power <- as.numeric(data$Global_active_power)
data<-subset(data,data$Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

#plotting plot1 and saving
png(filename ="plot1.png", width = 480, height = 480)
hist(data$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()