library(reshape2)
library(sqldf)
library(plyr)
head(mtcars)
names(mtcars)
mtcars$carName <- rownames(mtcars)
#meaning: use key(carname,gear) row`lize` (mpg,hp)
carMelt <- melt(mtcars
                ,id.vars=c("carName","gear","cyl")
                ,measure.vars=c("mpg","hp"))
tail(carMelt)
#meaning: select length(variable) from cylData group by cyl 
cylData <- dcast(carMelt,cyl ~ variable,mean)
#meaning: sqldf("select cyl,variable,avg(value) from carMelt group by cyl,variable")
cylData <- dcast(carMelt,cyl ~ variable,mean,subset=.(variable=="mpg"))
cylDataSQLRes <- sqldf("select cyl,avg(mpg),avg(hp) from mtcars group by cyl")
head(InsectSprays)
ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
sumCountBySpray = ddply(InsectSprays,.(spray),summarize,sum=sum(count))
sqldf("select spray,sum(count) from InsectSprays group by spray")
arrange(sumCountBySpray,sum)
mutate(sumCountBySpray,sumAll=sum(sum)/median(sum))


