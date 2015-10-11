#downloading dataset
if(!file.exists('data.zip')){
  datasource<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(datasource,destfile = "data.zip")
}

#unzip the data
unzip("data.zip")

#read the data
powerdata<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

#creating date and time column 
powerdata$DateTime<-paste(powerdata$Date, powerdata$Time)
#date and time format conversion
powerdata$DateTime<-strptime(powerdata$DateTime, "%d/%m/%Y %H:%M:%S")

#creating partial dataset
startdate <- which(powerdata$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
enddate <- which(powerdata$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
powerdata2 <- powerdata[startdate:enddate,]



#plot2
png(filename = "Plot2.png", width = 480, height = 480)
plot(powerdata2$DateTime, as.numeric(as.character(powerdata2$Global_active_power)),
     type='l',ylab="Global Active Power (Kilowatts)", xlab="")
dev.off()
