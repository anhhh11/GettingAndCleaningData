download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile="./housing.csv")
housing <- read.csv("housing.csv")
which(housing$AGS>=6 & housing$ACR==3)[1:3]
names(housing) <- strsplit(names(housing),split="wgtp")
names(housing)[123]
housing[,123]
#quiz4



library(sqldf)
library(jpeg)
library(reshape2)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",destfile="./jeff.jpg",mode="wb")
img  <- jpeg::readJPEG(source="./jeff.jpg",native=TRUE)
quantile(img,c(0.30,0.80))
library(plyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile="./gdp.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile="./edu.csv")

gdp <- read.csv("./gdp.csv",skip=5,header=FALSE)
names(gdp) <- c("CountryCode","Rank","V1","Economy","$")
class(gdp$Rank[1])
#Convert factor->character->numeric
gdp$Rank <- as.numeric(as.character(gdp$Rank))
class(gdp$Rank[1])
#Remove na row  
gdp <- subset(gdp,!is.na(Rank))
nrow(gdp)

gdp$"$" <- as.character(gdp$"$")
gdp$"$" <- as.numeric(sub(",","",gdp$"$"))
mean(gdp$"$")

edu <- read.csv("./edu.csv")

gdpJoinEdu <- join(gdp,edu,by="CountryCode",type="inner")
gdpJoinEdu <- merge(gdp,edu,all=FALSE)
nrow(gdpJoinEdu)
gdpJoinEduEndInJune  <- subset(gdpJoinEdu,grepl("^Fiscal year end: June",Special.Notes))
nrow(gdpJoinEduEndInJune)

arrange(gdpJoinEdu,-Rank)[13,"Economy"] #Thu thu tang dan
#1st way
sqldf("select Income_Group,avg(Rank) from gdpJoinEdu where Income_Group in ('High income: OECD','High income: nonOECD') group by Income_Group")
tapply(X=gdpJoinEdu$Rank, INDEX=gdpJoinEdu$Income.Group, FUN=mean)
#2st way
gdpJoinEduMelted <- melt(gdpJoinEdu,id.vars=c("Income.Group"),measure.vars=c("Rank"))
#3st way
dcast(gdpJoinEduMelted,Income.Group ~ variable,mean)

gdp5gdpGroupIncomeGroup <- data.frame(Rank.Group=cut(gdpJoinEdu$Rank,breaks=5)
                                      ,Income.Group=gdpJoinEdu$Income.Group)
nrow(subset(gdp5gdpGroupIncomeGroup,Rank.Group=="(0.811,38.8]" & Income.Group=="Lower middle income"))




library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sum(sapply(sampleTimes,year)==2012)
sum(sapply(sampleTimes,year)==2012 & sapply(sampleTimes,weekdays)=="Monday")

