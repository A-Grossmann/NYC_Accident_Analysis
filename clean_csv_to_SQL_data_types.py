import pandas as pd
import csv

#Opening the csv file
#Edditing the file to not contain the Location in point(,) format for processing
data = pd.read_csv("NYC_Accidents_2020.csv")
pd.set_option('display.max_column',20)
print(data.head())

print(data['CRASH DATE'])

data.pop("LOCATION")

data.to_csv("NYC_Accidents_2020_1.csv")
