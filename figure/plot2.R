# Download the zip file and unzip it

link = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('./exdata%2Fdata%2Fhousehold_power_consumption.zip')){
  download.file(link,'./exdata%2Fdata%2Fhousehold_power_consumption.zip', mode = 'wb')
  unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir = getwd())
}

## Read the data by keeping Date and Time as Characters and remaining numeric
tot_data <- read.table("household_power_consumption.txt", 
                       header=TRUE, 
                       sep=";", 
                       na.strings = "?", 
                       colClasses = c('character','character','numeric','numeric','numeric',
                                      'numeric','numeric','numeric','numeric'))

#Consolidating both Date and Time in a singel column
tot_data$datetime <- paste(tot_data$Date,tot_data$Time)
#Using sttrptime to convet the format from charcters to D/Time 
tot_data$datetime<-strptime(tot_data$datetime, "%d/%m/%Y %H:%M:%S")

#Convert the date field to be able to subset based on the date
tot_data$Date <- as.Date(tot_data$Date, format="%d/%m/%Y")

#Subsetting data related to First and second of Feb 2007
tot_data <- subset(tot_data, Date == "2007-02-01" | Date =="2007-02-02")

#Opening PNG device, plot the graph and close the device

png("plot2.png", width = 480, height = 480)
with(tot_data, plot(datetime, Global_active_power, type="l", xlab="Day", ylab="Global Active 
                 Power (kilowatts)"))
dev.off()

