# Obtain just the headers
headers <- read.csv2("household_power_consumption.txt", nrows=1, header=T)

# Using pipe to strip out unused data
hpc <- read.csv2(pipe("cat household_power_consumption.txt | grep  -e '^1/2/2007' -e '^2/2/2007'"),
                 stringsAsFactors=F, as.is=T, header=F, na.strings=c('?'),
                 col.names=colnames(headers))

datetimes <- paste(hpc$Time, hpc$Date)

plot(strptime(datetimes, format="%H:%M:%S %d/%m/%Y"), 
     hpc$Global_active_power, 
     xlab= "", 
     ylab= "Global Active Power (kilowatts)", 
     type='l', 
     col='black') 

dev.copy(png, file='plot2.png', width=480, height=480)
dev.off()
