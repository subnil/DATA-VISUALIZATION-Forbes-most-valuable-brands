# Loading library
library(bitops)
library(RCurl)
library(XML)

# Read the data from the file
u=c("C:\\Data Science with R\\Assignments\\Graded Assignments\\Topic 6.2 -  Data Visualization in R\\The World's Most Valuable Brands List - Forbes.html")
# Read the file as HTML table
tables=readHTMLTable(u)
# Convert it into data frame
data<-as.data.frame(tables$the_list)
# Removing the blank column
data<-data[,-1]
# Write it to a csv file
write.csv(data,"data.csv",row.names = FALSE)
# Read it from a csv file 
data<-read.csv("data.csv",na.strings =c("-"))
# Omitting the missing value
data<-na.omit(data)
str(data)
data$Rank<-gsub('#','',data$Rank)
data$Rank<-as.numeric(data$Rank)
data$Brand.Value<-gsub('\\$',' ',data$Brand.Value)
data$Brand.Value<-gsub('\\ B',' ',data$Brand.Value)
data$Brand.Value<-as.numeric(data$Brand.Value)
data$Brand.Revenue<-gsub('\\$',' ',data$Brand.Revenue)
data$Brand.Revenue<-gsub('\\ B',' ',data$Brand.Revenue)
data$Brand.Revenue<-as.numeric(data$Brand.Revenue)
data$Company.Advertising<-gsub('\\$',' ',data$Company.Advertising)
data$Company.Advertising<-gsub('\\ B',' ',data$Company.Advertising)

# Write into a csv file to convert milion to billion
write.csv(data,"data1.csv",row.names = FALSE)

# Read it from data set
data2<-read.csv("data1.csv")
str(data2)

# Subset the data for industry = Technology
data3<-subset(data2,Industry=="Technology")
# Plot the data
library(ggplot2)
z<-ggplot(data3,aes(x=company.adv,y=Brand.Revenue))
z+geom_point(aes(colour=Brand,size=Brand.Revenue))+scale_x_continuous("Company Advertising in Billions of $",breaks = seq(0,4,1))+scale_y_continuous("Brand Ravenue in Billions of $", breaks = seq(0,200, by = 50))+theme(plot.title = element_text(hjust=0.5))+geom_text(aes(label=Brand,colour=Brand,size=Brand.Revenue),hjust=1.005,vjust=1.5)+ggtitle("Technology")
# Subset the data for industry = Luxury                    
data4<-subset(data2,Industry=="Luxury")
# Plot the data
z<-ggplot(data4,aes(x=company.adv,y=Brand.Revenue))
z+geom_point(aes(colour=Brand,size=Brand.Revenue))+scale_x_continuous("Company Advertising in Billions of $",breaks = seq(0,4.8,0.1))+scale_y_continuous("Brand Ravenue in Billions of $", breaks = seq(0,10, by = 2))+theme_bw()+geom_text(aes(label=Brand,colour=Brand,size=Brand.Revenue),hjust=1.005,vjust=1.5)+ggtitle("Luxury")
# Subset the data for industry = Finaltial
data5<-subset(data2,Industry=="Financial Services")
# Plot The data
z<-ggplot(data5,aes(x=company.adv,y=Brand.Revenue))
z+geom_point(aes(colour=Brand,size=company.adv))+scale_x_continuous("Company Advertising in Billions of $",breaks = seq(0,3.4,0.1))+scale_y_continuous("Brand Ravenue in Billions of $", breaks = seq(0,100, by = 10))+theme_bw()+geom_text(aes(label=Brand,colour=Brand,size=company.adv),hjust=1.0,vjust=1.5)+ggtitle("Financial")
# Subset the data for industry =Automotive
data6<-subset(data2,Industry=="Automotive")
# Plot the data
z<-ggplot(data6,aes(x=company.adv,y=Brand.Revenue))
z+geom_point(aes(colour=Brand,size=Brand.Revenue))+scale_x_continuous("Company Advertising in Billions of $",breaks = seq(0,5.4,0.1))+scale_y_continuous("Brand Ravenue in Billions of $", breaks = seq(0,170, by = 10))+theme_bw()+geom_text(aes(label=Brand,colour=Brand,size=Brand.Revenue),hjust=1.005,vjust=1.5)+ggtitle("Automotive")
