#Import libraries
library(ggplot2)
library(sampling)

library(ggmap)

#Read data
injur_df = read.csv("VGH 2008-2017.csv")
fatal_df = read.csv("VPD Fatalities 2006-18APR2018.csv")

#view header of dataset
head(injur_df)
head(fatal_df)

#remove empty row


droplevels(injur_df$Age)
injur_df<-droplevels(injur_df)


#subset data
fatal_old <- fatal_df[!(fatal_df$Age =="0-10" | fatal_df$Age =="10-19" | fatal_df$Age =="20-29" | fatal_df$Age =="30-39" | fatal_df$Age =="40-49" | fatal_df$Age =="50-59"),]


                      
#Analyze catagorical variables:
par(mfrow = c(2,2))
barplot(table(injur_df$Age), xlab ="Age", ylab ="Frequency", main = "Age Distribution for Injury Collisions" ,col=rainbow(5), legend =c(), las = 2)

barplot(table(injur_df$Modes), ylab ="Frequency", main = "Types of Collisions", col=rainbow(5), legend =c(), las =2)

barplot(table(fatal_df$Age), xlab ="Age", ylab ="Frequency", main = "Age Distribution for Fatal Collisions",las = 2,  col=rainbow(5), legend =c())
barplot(table(fatal_old$Location.Type), main = "Location of Fatal Collisions Involving Seniors", ylab ="Frequency", col=rainbow(5), legend =c(), las = 2)


#make the primary map layer
map = get_map(location = "Vancouver", zoom = 13, scale = "auto",  maptype = "satellite", api_key = "AIzaSyBBhkITZ-33zzVWjhf8NuRHSblxvE7gXAw")

#injured old
ggmap(map, extent = "device") + geom_density2d(data = injur_old,aes(x = Longitude, y = Latitude), size = 0.3) + stat_density2d(data = injur_old,aes(x = Longitude, y = Latitude, fill = ..level.., alpha = ..level..), size = 0.01, bins = 16, geom = "polygon") + scale_fill_gradient(low = "green", high = "red") + scale_alpha(range = c(0, 0.3), guide = FALSE)

#fatal old
ggmap(map, extent = "device") + geom_density2d(data = fatal_old,aes(x = Longitude, y = Latitude), size = 0.3) + stat_density2d(data = fatal_old,aes(x = Longitude, y = Latitude, fill = ..level.., alpha = ..level..), size = 0.01, bins = 16, geom = "polygon") + scale_fill_gradient(low = "green", high = "red") + scale_alpha(range = c(0, 0.3), guide = FALSE)



