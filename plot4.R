setwd("C:/Coursera/Data") 

# 2007-02-01 and 2007-02-02
electric <- as.data.frame(read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?"))

electric$Date_Time = paste(electric$Date, electric$Time, sep=" ")

electric$Date_Time = strptime(electric$Date_Time, "%d/%m/%Y %H:%M:%S")
electric$Global_active_power = as.numeric(electric$Global_active_power)
electric$Sub_metering_1 = as.numeric(electric$Sub_metering_1)
electric$Sub_metering_2 = as.numeric(electric$Sub_metering_2)
electric$Sub_metering_3 = as.numeric(electric$Sub_metering_3)

subset_electric = subset(electric, Date_Time >= strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S") & Date_Time <= strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S"))

# summary(subset_electric$Global_active_power)

png(file="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
#
with(subset_electric, plot(Date_Time, Global_active_power / 500, type="l", xlab="", ylab="Global Active Power"))
#
with(subset_electric, plot(Date_Time, Voltage, type="l", xlab="datetime", ylab="Voltage"))
#
with(subset_electric, plot(Date_Time, Sub_metering_1, type = "n", yaxt="n", ylab="Energy sub metering", xlab=""))
with(subset_electric, lines(Date_Time, Sub_metering_1, type="l", col="black"))
with(subset_electric, lines(Date_Time, Sub_metering_2, type="l", col="red"))
with(subset_electric, lines(Date_Time, Sub_metering_3, type="l", col="blue"))
axis(2, at=c(10,20,30))
legend("topright", lwd = "1", bty="n", col = c("black", "red", "blue" ), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#
with(subset_electric, plot(Date_Time, Global_reactive_power, type="l", xlab="datetime"))
dev.off()
