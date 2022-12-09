#Prepping the data 

    #In PYTHON

#         import pandas as pd
#         import csv

#         #Opening the csv file
#         #Edditing the file to not contain the Location in point(,) format for processing:

#         data = pd.read_csv("NYC_Accidents_2020.csv")
#         pd.set_option('display.max_column',20)
#         print(data.head())

#         print(data['CRASH DATE'])

#         data.pop("LOCATION")

#         data.to_csv("NYC_Accidents_2020_1.csv")

#Migrate the csv file into mysql to better sort it:

    #In SQL:

        # USE accidents_nyc;
        # DROP TABLE all_accidents;
        # CREATE TABLE all_accidents (
        #             ROW_ID INTEGER DEFAULT NULL,
        #             CRASH_DATE DATE,
        #             CRASH_TIME TIME DEFAULT NULL,
        #             BOROUGH VARCHAR(255) DEFAULT NULL,
        #             ZIP_CODE INTEGER DEFAULT NULL,
        #             LATITUDE DECIMAL(7, 4) DEFAULT NULL,
        #             LONGITUDE DECIMAL(7, 4) DEFAULT NULL,
        # --             LOCATION POINT SRID 4326 default null,
        #             STREET_NAME VARCHAR(255) DEFAULT NULL,
        #             INTERSECTING_STREET_NAME VARCHAR(255) DEFAULT NULL,
        #             OFF_STREET_NAME VARCHAR(255) DEFAULT NULL,
        #             NUMBER_OF_PERSONS_INJURED INTEGER DEFAULT NULL,
        #             NUMBER_OF_PERSONS_KILLED INTEGER DEFAULT NULL,
        #             NUMBER_OF_PEDESTRIANS_INJURED INTEGER DEFAULT NULL,
        #             NUMBER_OF_PEDESTRIANS_KILLED INTEGER DEFAULT NULL,
        #             NUMBER_OF_CYCLIST_INJURED INTEGER DEFAULT NULL,
        #             NUMBER_OF_CYCLIST_KILLED INTEGER DEFAULT NULL,
        #             NUMBER_OF_MOTORIST_INJURED INTEGER DEFAULT NULL,
        #             NUMBER_OF_MOTORIST_KILLED INTEGER DEFAULT NULL,
        #             CONTRIBUTING_FACTOR_VEHICLE_1 VARCHAR(255) DEFAULT NULL,
        #             CONTRIBUTING_FACTOR_VEHICLE_2 VARCHAR(255) DEFAULT NULL,
        #             CONTRIBUTING_FACTOR_VEHICLE_3 VARCHAR(255) DEFAULT NULL,
        #             CONTRIBUTING_FACTOR_VEHICLE_4 VARCHAR(255) DEFAULT NULL,
        #             CONTRIBUTING_FACTOR_VEHICLE_5 VARCHAR(255) DEFAULT NULL,
        #             COLLISION_ID INTEGER PRIMARY KEY DEFAULT 0,
        #             VEHICLE_TYPE_CODE_1 VARCHAR(255) DEFAULT NULL,
        #             VEHICLE_TYPE_CODE_2 VARCHAR(255) DEFAULT NULL,
        #             VEHICLE_TYPE_CODE_3 VARCHAR(255) DEFAULT NULL,
        #             VEHICLE_TYPE_CODE_4 VARCHAR(255) DEFAULT NULL,
        #             VEHICLE_TYPE_CODE_5 VARCHAR(255) DEFAULT NULL);

        # LOAD DATA
        # INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\NYC_Accidents_2020_1.csv'
        # INTO TABLE all_accidents
        # FIELDS TERMINATED BY ','
        # optionally ENCLOSED BY '"'
        # LINES TERMINATED BY '\r\n'
        # IGNORE 1 lines
        # (@vROW_ID,@vCRASH_DATE, @vCRASH_TIME, @vBOROUGH, @vZIP_CODE,
        # @vLATITUDE, @vLONGITUDE, @vSTREET_NAME, @vINTERSECTING_STREET_NAME, @vOFF_STREET_NAME,
        #  @vNUMBER_OF_PERSONS_INJURED, @vNUMBER_OF_PERSONS_KILLED, @vNUMBER_OF_PEDESTRIANS_INJURED,
        #  @vNUMBER_OF_PEDESTRIANS_KILLED, @vNUMBER_OF_CYCLIST_INJURED,
        #  @vNUMBER_OF_CYCLIST_KILLED, @vNUMBER_OF_MOTORIST_INJURED, @vNUMBER_OF_MOTORIST_KILLED,
        #  @vCONTRIBUTING_FACTOR_VEHICLE_1, @vCONTRIBUTING_FACTOR_VEHICLE_2, @vCONTRIBUTING_FACTOR_VEHICLE_3, @vCONTRIBUTING_FACTOR_VEHICLE_4,
        #  @vCONTRIBUTING_FACTOR_VEHICLE_5, @vCOLLISION_ID, @vVEHICLE_TYPE_CODE_1, @vVEHICLE_TYPE_CODE_2, @vVEHICLE_TYPE_CODE_3, @vVEHICLE_TYPE_CODE_4, @vVEHICLE_TYPE_CODE_5)

        # SET
        # ROW_ID = NULLIF(@vROW_ID,''),
        # CRASH_DATE = NULLIF(@vCRASH_DATE,''),
        # CRASH_TIME= NULLIF(@vCRASH_TIME,''),
        # BOROUGH = NULLIF(@vBOROUGH,''),
        # ZIP_CODE = NULLIF(@vZIP_CODE,''),
        # LATITUDE = NULLIF(@vLATITUDE,''),
        # LONGITUDE = NULLIF(@vLONGITUDE,''),
        # STREET_NAME = NULLIF(@vSTREET_NAME,''),
        # INTERSECTING_STREET_NAME = NULLIF(@vINTERSECTING_STREET_NAME,''),
        # OFF_STREET_NAME = NULLIF(@vOFF_STREET_NAME,''),
        # NUMBER_OF_PERSONS_INJURED = NULLIF(@vNUMBER_OF_PERSONS_INJURED,''),
        # NUMBER_OF_PERSONS_KILLED = NULLIF(@vNUMBER_OF_PERSONS_KILLED,''),
        # NUMBER_OF_PEDESTRIANS_INJURED = NULLIF(@vNUMBER_OF_PEDESTRIANS_INJURED,''),
        # NUMBER_OF_PEDESTRIANS_KILLED = NULLIF(@vNUMBER_OF_PEDESTRIANS_KILLED,''),
        # NUMBER_OF_CYCLIST_INJURED = NULLIF(@vNUMBER_OF_CYCLIST_INJURED,''),
        # NUMBER_OF_CYCLIST_KILLED  = NULLIF(@vNUMBER_OF_CYCLIST_KILLED,''),
        # NUMBER_OF_MOTORIST_INJURED = NULLIF(@vNUMBER_OF_MOTORIST_INJURED,''),
        # NUMBER_OF_MOTORIST_KILLED = NULLIF(@vNUMBER_OF_MOTORIST_KILLED,''),
        # CONTRIBUTING_FACTOR_VEHICLE_1 = NULLIF(@vCONTRIBUTING_FACTOR_VEHICLE_1,''),
        # CONTRIBUTING_FACTOR_VEHICLE_2 = NULLIF(@vCONTRIBUTING_FACTOR_VEHICLE_2,''),
        # CONTRIBUTING_FACTOR_VEHICLE_3= NULLIF(@vCONTRIBUTING_FACTOR_VEHICLE_3,''),
        # CONTRIBUTING_FACTOR_VEHICLE_4 = NULLIF(@vCONTRIBUTING_FACTOR_VEHICLE_4,''),
        # CONTRIBUTING_FACTOR_VEHICLE_5 = NULLIF(@vCONTRIBUTING_FACTOR_VEHICLE_5,''),
        # COLLISION_ID = NULLIF(@vCOLLISION_ID,''),
        # VEHICLE_TYPE_CODE_1 = NULLIF(@vVEHICLE_TYPE_CODE_1,''),
        # VEHICLE_TYPE_CODE_2 = NULLIF(@vVEHICLE_TYPE_CODE_2,''),
        # VEHICLE_TYPE_CODE_3 = NULLIF(@vVEHICLE_TYPE_CODE_3,''),
        #  VEHICLE_TYPE_CODE_4 = NULLIF(@vVEHICLE_TYPE_CODE_4,''),
        #  VEHICLE_TYPE_CODE_5 = NULLIF(@vVEHICLE_TYPE_CODE_5,'')
        # ;


#1.) What areas in NYC have the most accidents? Where are the most severe accidents located?

    #i.) What areas of NYC has the most accidents?

        #A Export the xyz_severity table to csv file all_accidents.csv with the 
        #  Export button in mySQL queary on the all_accident table.

        #B Use QGIS software and add csv all_accidents.csv.  
        #  Add the all_accidents.csv file in as a layer with longitude and latitude for all accidents

    #ii.)  What are the most severe accidents locate?

        #A For this we need to come up with a formula for severity.
        #  In order to only show deadly or injurious crashes:
        #   -I weighted the value of severity of a deadly crash to be 3
        #   -A crash where someone was injured to be 1
        #   -and all other crashes 0.
        
        #IN SQL

        # CREATE TABLE xyz_severity AS 
        # SELECT Latitude, Longitude, COLLISION_ID
        # NUMBER_OF_PERSONS_INJURED as injured, 
        # NUMBER_OF_PERSONS_KILLED as killed,
        # NUMBER_OF_PEDESTRIANS_INJURED + NUMBER_OF_PEDESTRIANS_KILLED as pedestrians,
        # NUMBER_OF_CYCLIST_INJURED +NUMBER_OF_CYCLIST_KILLED as cyclists, 
        # NUMBER_OF_PERSONS_INJURED + 3*NUMBER_OF_PERSONS_KILLED as crash_severity
        # FROM
        # all_accidents
        # WHERE Latitude IS NOT NULL or Longitude IS NOT NULL;

        #B.) Export tthe csv file
        
        #C.) Create a heatmap with QGIS


 #2.) What are the causes of most accidents? Can the contributing factors for the vehicles be classified?

    #i.) What are the causes of most accidents?

        #A.) First sort the data without reclassifying the contributing factors.  Tring to find out what causes occur the most.
        
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
            #  Then Export the csv file as contributing_factors.csv

        #B.) Plot it in R

            #    Using R studio
            #    After exicuiting in SQL the queary to put all factors into a union
                #Retrieve the csv file as factors_union
                factors_union<- read.csv(file = "C:/Users/Andy_Code/Desktop/NYC_Accidents/Contributing_factors_union_all.csv", header = TRUE, stringsAsFactors = TRUE)

                #Create the basplot
                c<-ggplot(factors_union,aes(CONTRIBUTING_FACTOR_VEHICLE_1)) 

                #Add features to plot
                c+ xlab("Contributing Factors")+
                geom_bar(col = c(rep(x=c("Red", "Blue", "Green"), times = 18)))+
                theme(axis.text.x = element_text(size = 4, angle = 90, vjust = 1, hjust=1),
                axis.title.x =element_text(size = 10, angle=0))

    #ii.) Can the contributing factors for the vehicles be classified?
        #A Reclassify the data.
                #Create a Table to use to determine all unique instances of the contributing factors in the data. 
                #The five contributing factors columns were joined to determine all unique instances 
                    #IN SQL:

                #CREATE TABLE CONTRIBUTING_FACTORS AS SELECT * FROM
                #     (SELECT 
                #         Contributing_Factor_Vehicle_1 AS ALL_FACTORS
                #     FROM
                #         all_accidents UNION SELECT 
                #         Contributing_Factor_Vehicle_2 AS ALL_FACTORS
                #     FROM
                #         all_accidents UNION SELECT 
                #         Contributing_Factor_Vehicle_3 AS ALL_FACTORS
                #     FROM
                #         all_accidents UNION SELECT 
                #         Contributing_Factor_Vehicle_4 AS ALL_FACTORS
                #     FROM
                #         all_accidents UNION SELECT 
                #         Contributing_Factor_Vehicle_5 AS ALL_FACTORS
                #     FROM
                #         all_accidents) TBL
                # WHERE
                #     ALL_FACTORS IS NOT NULL
                # GROUP BY ALL_FACTORS;

                ##The resulting table here is a table of all the unique contributing factors.
                ## I further classified the uniqu factors into 6 catagories:

                    # id  class   discription_of_class
                    # 1   A   unknown
                    # 2   B   distraction
                    # 3   C   persons_condition_illness
                    # 4   D   Bar_road_conditions
                    # 5   E   mannurisms
                    # 6   F   malfunctions
                    # 7   G   NULL


                #Add on a primary key to make the two tables relatable to one another:

                    # ALTER TABLE contributing_factors
                    # ADD id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT;

                # ADD A ROW WITH VALUES TO TABLE:

                    # DROP TABLE Classification;
                    # CREATE TABLE Classification (
                    #     id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
                    #     classification VARCHAR(255)
                    # );

                    # INSERT INTO classification (classification)
                    # VALUES 
                    # ('A'),('B'),('E'),('E'),('E'),('B'),('A'),('E'),('E'),
                    # ('C'),('E'),('E'),('E'),('F'),('F'),('B'),('E'),('C'),('C'),
                    # ('C'),('C'),('D'),('E'),('D'),('B'),('F'),('C'),('F'),('D'),
                    # ('D'),('D'),('E'),('E'),('D'),('C'),('D'),('B'),('D'),('D'),
                    # ('F'),('F'),('F'),('B'),('B'),('C'),('D'),('F'),('F'),('B'),
                    # ('C'),('B'),('B'),('F'),('B'),('D');


                    # -- join tables to add classification

                    # CREATE TABLE contributing_factors_class AS SELECT * FROM (
                    #     SELECT c.id, cf.ALL_FACTORS, c.classification
                    #     FROM contributing_factors cf
                    #     JOIN classification c
                    #     ON cf.id = c.id) TEMP_TABLE;
                    # DROP TABLE contributing_factors;
                    # DROP TABLE classification;


                    #     CREATE TABLE factor_totals
                    #     AS SELECT * FROM(
                    #     SELECT tbl.class, tbl.total, TBL.total * 100.0 / sum(TBL.total) over() as percent_total, ck.discription_of_class 
                    #     FROM 
                    #         (SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
                    #         WHERE
                    #         class_1 = 'B' or class_2 = 'B' or class_3 = 'B' OR class_4 = 'B' OR class_4 = 'B'
                    #         UNION
                    #         SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
                    #         WHERE
                    #         class_1 = 'C' or class_2 = 'C' or class_3 = 'C' OR class_4 = 'C' OR class_4 = 'C'
                    #         UNION
                    #         SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
                    #         WHERE
                    #         class_1 = 'D' or class_2 = 'D' or class_3 = 'D' OR class_4 = 'D' OR class_4 = 'D'
                    #         UNION
                    #         SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
                    #         WHERE
                    #         class_1 = 'E' or class_2 = 'E' or class_3 = 'E' OR class_4 = 'E' OR class_4 = 'E'
                    #         UNION
                    #         SELECT class_1 as class, count(*) as total FROM all_accidents_with_factors
                    #         WHERE
                            
                    #         class_1 = 'F' or class_2 = 'F' or class_3 = 'F' OR class_4 = 'F' OR class_4 = 'F'
                    #         ORDER BY total DESC) TBL
                    #         JOIN
                    #         class_key ck
                    #         ON
                    #         ck.class = tbl.class) TBL_2;

        #B Make a bar graph showing the classifications for data
            #Import data:

                factors<- read.csv(file = "C:/Users/Andy_Code/Desktop/NYC_Accidents/factor_totals.csv", header = TRUE, stringsAsFactors = TRUE)


                 barplot(factors$total, main = "Contributing Factors of cars", 
                    names.arg = factors$discription_of_class,col= c('#228b22', '#86031A', '#fa8072', '#add8e6', '#daa520'), las=2, 
                    cex.names=0.4, cex.axis=0.7)

# 3.) what time of day is there the most accidents?

    #i.) What time of day?
        #A Download the all_accidents.csv data as a table and convert the times to a numeric using the lubridate package
            #in R:
                    library(lubridate)

                    #Download into table
                    data <- read.table(file = "C:/Users/Andy_Code/Desktop/NYC_Accidents/all_accidents.csv", header = TRUE, sep = ",")

                    #Change Crash time into a numeric value to use hms() function taken from the lubridate package
                    data$CRASH_TIME<-as.numeric(hms(data$CRASH_TIME))
                    data$CRASH_TIME<-data$CRASH_TIME/3600
        #B Create a histogram plot:
            #In R:        
                    #Create data for plot and tie gradiant to aesthetics
                    d<<-ggplot(data, aes(CRASH_TIME, fill =..x..))

                    #Create Histogram with the different times
                    d+geom_histogram(binwidth = 1)+
                    labs(title = "Hourly Crash Count", y = "Number of Incidents", x = "Hour")+
                    scale_fill_distiller(palette = "Blues")

# 4.) What time of day and where do Alcohol Insident Accidents Occur?
    # i.) What time of day?

        #A.) Make a seperate Alcohol_Involvement csv file with sql quearies

            #IN SQL

            # use accidents_nyc;

            # CREATE TABLE alcohol_involvement AS 
            # SELECT ROW_ID, LONGITUDE, LATITUDE, CRASH_TIME
            # FROM all_accidents
            # WHERE
            # CONTRIBUTING_FACTOR_VEHICLE_1 = 'alcohol involvement';

        #B.) Graph the data with a histogram

            #Create a histogram for Alcahol involvment time of day
            library(lubridate)

            Alcohol_Inv<- read.table(file = "C:/Users/Andy_Code/Desktop/NYC_Accidents/Alcohol_Involvement_CRASH_TIME_LON_LAT.csv", header = TRUE, sep = ",")

            #Change Crash time into a numeric value to use hms() function taken from the lubridate package
            Alcohol_Inv$CRASH_TIME<-as.numeric(hms(Alcohol_Inv$CRASH_TIME))
            Alcohol_Inv$CRASH_TIME<-Alcohol_Inv$CRASH_TIME/3600

            #Create data for plot and tie gradiant to aesthetics
            e<<-ggplot(Alcohol_Inv, aes(CRASH_TIME, fill =..x..))

            #Create Histogram with the different times
            e+geom_histogram(binwidth = 1)
            +     labs(title = "Alcohol Envolved Crash", y = "Number of Incidents", x = "Hour")
            +     scale_fill_gradient(low = "red", high = "blue") 
            +     scale_x_continuous(minor_breaks = seq(0, 25, 1))

    #ii.) Where?

        #A.) Go into QGIS and add a csv layer for Alcohol_Involvement using the new Alcohol_Involvement_CRASH_TIME_LON_LAT.csv file
        #    See attached map with layers for locations


