# Obtain just the headers
headers <- read.csv2("household_power_consumption.txt", nrows=1, header=T)

# Using pipe to strip out unused data
hpc <- read.csv2(pipe("cat household_power_consumption.txt | grep  -e '^1/2/2007' -e '^2/2/2007'"),
                 stringsAsFactors=F, as.is=T, header=F, na.strings=c('?'),
                 col.names=colnames(headers))

datetimes <- strptime(paste(hpc$Time, hpc$Date), format="%H:%M:%S %d/%m/%Y") 

plot(datetimes, 
     hpc$Sub_metering_1, 
     xlab= "", 
     ylab= "Energing sub metering", 
     type='l', 
     col='black') 

points(datetimes, hpc$Sub_metering_2, type='l', col= "red")
points(datetimes, hpc$Sub_metering_3, type='l', col= "blue")
par(xpd=TRUE)
legend("topright", 
       lwd= 1,
       cex=0.5,
       pt.cex=1,
       col=c("black", "blue","red"), 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))

dev.copy(png, file='plot3.png', width=480, height=480)
dev.off()
