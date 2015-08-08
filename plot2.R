library(lubridate) #opens Lubridate
require(lubridate) #forces date functions to use Lubridate notation
file <- "household_power_consumption.txt"
pc <- read.delim(file, sep=";") #reading in data
pc_time <- paste(pc[ ,1], pc [ ,2]) #mergning date and time together
pc_time2 <- parse_date_time (pc_time, "%d%m%Y %H%M%S", truncated = 3) #converting time 
#information to Lubridate format
pc$dt <- pc_time2 #adds the formatted time data to the matrix
pc_range <- pc[pc$dt < dmy(03022007), ] #subsets for data earlier than the end time
pc_range <- pc_range[pc_range$dt > dmy(01022007), ] #subsets for after the start time

pc_range$Global_active_power <- as.numeric(as.character(pc_range$Global_active_power)) 
#converts column to numeric
pc_range$Global_active_power <- pc_range$Global_active_power*1000 
#multiplies in order to get Kilowatts
png(file = "plot1.png", width = 480, height = 480) #Creates the PNG file
hist(pc_range$Global_active_power, col="red", main = paste("Global Active Power"),
     xlab = "Global Active Power (kilowatts)") #Creates Plot 1
dev.off()

png(file = "plot2.png", width = 480, height = 480) #Creates the PNG file
plot(pc_range$dt, pc_range$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "") #creates Plot 2
dev.off()