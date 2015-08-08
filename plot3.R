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

png(file = "plot3.png", width = 480, height = 480) #Creates the PNG file
pc_range$Sub_metering_1 <- as.numeric(as.character(pc_range$Sub_metering_1)) 
#converts column from factor to numeric
pc_range$Sub_metering_2 <- as.numeric(as.character(pc_range$Sub_metering_2))
#strangely 3 is already numeric
plot(pc_range$dt, pc_range$Sub_metering_1, type="l", xlab ="", ylab = "Energy sub metering")
points(pc_range$dt, pc_range$Sub_metering_2, type="l", col = "red")
points(pc_range$dt, pc_range$Sub_metering_3, type="l", col = "blue")#Creates plot 3
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) #creates legend
dev.off()

