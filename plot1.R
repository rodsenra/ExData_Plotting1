# Obtain just the headers
headers <- read.csv2("household_power_consumption.txt", nrows=1, header=T)

# Using pipe to strip out unused data
hpc <- read.csv2(pipe("cat household_power_consumption.txt | grep  -e '^1/2/2007' -e '^2/2/2007'"),
                 stringsAsFactors=F, as.is=T, header=F, na.strings=c('?'),
                 col.names=colnames(headers))

hist(as.numeric(hpc$Global_active_power), 
     main="Global Active Power",
     ylab="Frequency",
     xlab="Global Active Power (kilowatts)",
     col="red")

dev.copy(png, file='plot1.png', width=480, height=480)
dev.off()