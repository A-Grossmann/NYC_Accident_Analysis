 
 ## What are the contributing factors of an accident?

 factors<- read.csv(file = "C:/Users/Andy_Code/Desktop/NYC_Accidents/factor_totals.csv", header = TRUE, stringsAsFactors = TRUE)


 barplot(factors$total, main = "Contributing Factors of cars", 
    names.arg = factors$discription_of_class,col= c('#228b22', '#86031A', '#fa8072', '#add8e6', '#daa520'), las=2, 
    cex.names=0.4, cex.axis=0.7)

 #In SQL make the queary and export to csv file:

# SELECT * FROM (
# SELECT a.CONTRIBUTING_FACTOR_VEHICLE_1 FROM all_accidents_with_factors a
# UNION ALL
# SELECT b.CONTRIBUTING_FACTOR_VEHICLE_2 FROM all_accidents_with_factors b
# UNION ALL
# SELECT c.CONTRIBUTING_FACTOR_VEHICLE_3 FROM all_accidents_with_factors c
# UNION ALL
# SELECT d.CONTRIBUTING_FACTOR_VEHICLE_4 FROM all_accidents_with_factors d
# UNION ALL
# SELECT e.CONTRIBUTING_FACTOR_VEHICLE_5 FROM all_accidents_with_factors e) tbl
# WHERE
# NOT CONTRIBUTING_FACTOR_VEHICLE_1 = 'Unspecified'
# LIMIT 500000;



 #Showing types of cars using the ggplot2 in R
 #After exicuiting in SQL the queary to put all factors into a union
 factors_union<- read.csv(file = "C:/Users/Andy_Code/Desktop/NYC_Accidents/Contributing_factors_union_all.csv", header = TRUE, stringsAsFactors = TRUE)

c<-ggplot(factors_union,aes(CONTRIBUTING_FACTOR_VEHICLE_1)) 

c+ xlab("Contributing Factors")+
geom_bar(col = c(rep(x=c("Red", "Blue", "Green"), times = 18)))+
theme(axis.text.x = element_text(size = 2, angle = 90, vjust = 1, hjust=1),
axis.title.x =element_text(size = 10, angle=0))
 

#With factors classified... IN SQL then export to csv file:

# SELECT * FROM (
# SELECT a.class_1 FROM all_accidents_with_factors a
# UNION ALL
# SELECT b.class_2 FROM all_accidents_with_factors b
# UNION ALL
# SELECT c.class_3 FROM all_accidents_with_factors c
# UNION ALL
# SELECT d.class_4 FROM all_accidents_with_factors d
# UNION ALL
# SELECT e.class_5 FROM all_accidents_with_factors e) tbl
# WHERE
# NOT class_1 = 'A'
# LIMIT 500000;

#Download into R Studio the Contributing_Factors_UNion table

 factors_union<- read.csv(file = "C:/Users/Andy_Code/Desktop/NYC_Accidents/Contributing_factors_union_all_class.csv", header = TRUE, stringsAsFactors = TRUE)

#Create a plot
> c<-ggplot(factors_union,aes(x = as.factor(class_1)))
> c+ labs(title = "Contributing Factors", y = "Number of Incidents", x = "Contributing Factor Catagory")+ geom_bar(fill = c("Red", "Blue", "Green","Yellow","Orange","Brown")) + theme(axis.text.x = element_text(size = 10, angle = 90, vjust = 1, hjust=1),axis.title.x =element_text(size = 10, angle=0)) 

#Need to fill as factor
c+ labs(title = "Contributing Factors", y = "Number of Incidents", x = "Contributing Factor Catagory")+ geom_bar(aes(fill=as.factor(class_1))) + theme(axis.text.x = element_text(size = 10, angle = 90, vjust = 1, hjust=1),axis.title.x =element_text(size = 10, angle=0)) 
+ scale_fill_discrete(name = "Classification", labels = c("Distraction", "Driver Condition", "Road Conditions", "Draver Mannurisms", "Mannurisms","Malfunctions"))

# 3.) what time of day is there the most accidents

library(lubridate)

#Download into table
all_accidents <- read.table(file = "C:/Users/Andy_Code/Desktop/NYC_Accidents/all_accidents.csv", header = FALSE, sep = ",")

#Change Crash time into a numeric value to use hms() function taken from the lubridate package
data$CRASH_TIME<-as.numeric(hms(data$CRASH_TIME))
data$CRASH_TIME<-data$CRASH_TIME/3600

#Create data for plot and tie gradiant to aesthetics
d<<-ggplot(data, aes(CRASH_TIME, fill =..x..))

#Create Histogram with the different times
d+geom_histogram(binwidth = 1)+
labs(title = "Hourly Crash Count", y = "Number of Incidents", x = "Hour")+
scale_fill_distiller(palette = "Blues")
