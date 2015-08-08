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

png(file = "plot4.png", width = 480, height = 480) #Creates the PNG file
par(mfrow = c(2,2)) #creates layout for multiple graphs for plot 4
plot(pc_range$dt, pc_range$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = "") #repeat from plot 2
pc_range$Voltage <- as.numeric(as.character(pc_range$Voltage)) #to numeric
plot(pc_range$dt, pc_range$Voltage, type="l", xlab = "date/time", ylab = "Voltage") #creates one of the Plot 4 sub-plots
plot(pc_range$dt, pc_range$Sub_metering_1, type="l", xlab ="", ylab = "Energy sub metering")
points(pc_range$dt, pc_range$Sub_metering_2, type="l", col = "red")
points(pc_range$dt, pc_range$Sub_metering_3, type="l", col = "blue")#Repeat from plot 3
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) #Recreates plot 3 legend
pc_range$Global_reactive_power <- as.numeric(as.character(pc_range$Global_reactive_power)) 
plot(pc_range$dt, pc_range$Global_reactive_power, type="l", xlab = "date/time", ylab = "Global_reactive_power")
#creates the other needed sub-plot of Plot 4
dev.off()