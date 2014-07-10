# Obtain just the headers
headers <- read.csv2("household_power_consumption.txt", nrows=1, header=T)

# Using pipe to strip out unused data
hpc <- read.csv2(pipe("cat household_power_consumption.txt | grep  -e '^1/2/2007' -e '^2/2/2007'"),
                 stringsAsFactors=F, as.is=T, header=F, na.strings=c('?'),
                 col.names=colnames(headers))

datetimes <- strptime(paste(hpc$Time, hpc$Date), format="%H:%M:%S %d/%m/%Y") 

par(mfrow=c(2,2))

# Plot 1
plot(datetimes, 
     hpc$Global_active_power, 
     xlab= "", 
     ylab= "Global Active Power", 
     type='l', 
     col='black',
     cex=0.3,
     cex.lab=0.7,
     yaxt="n") 
axis(2,cex.axis=0.7)

# Plot 2
plot(datetimes, 
     hpc$Voltage, 
     xlab= "datetime", 
     ylab= "Voltage", 
     type='l', 
     col='black',
     cex.lab=0.7,
     yaxt="n") 
axis(2,cex.axis=0.7) 

# Plot 3
plot(datetimes, 
     hpc$Sub_metering_1, 
     xlab= "", 
     ylab= "Energing sub metering", 
     type='l', 
     col='black',
     cex.lab=0.7,
     yaxt="n") 
axis(2,cex.axis=0.7) 

points(datetimes, hpc$Sub_metering_2, type='l', col= "red")
points(datetimes, hpc$Sub_metering_3, type='l', col= "blue")
par(xpd=TRUE)
legend("topright", 
       lwd= 1,
       cex=0.4,
       pt.cex=4,
       bty="n",
       col=c("black", "blue","red"), 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))

# Plot 4
plot(datetimes, 
     hpc$Global_reactive_power, 
     ylab= "Global_reactive_power", 
     xlab= "datetime", 
     type='l', 
     col='black',
     cex.lab=0.7,
     yaxt="n") 
axis(2,cex.axis=0.7) 

dev.copy(png, file='plot4.png', width=480, height=480)
dev.off()
