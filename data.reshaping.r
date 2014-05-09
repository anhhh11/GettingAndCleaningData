library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt)
tail(carMelt)

library(plyr)
letter <- function(x, n = 1) {
  if (n < 0) {
    nc <- nchar(x)
    n <- nc + n + 1
  }
  tolower(substr(x, n, n))
}
vowels <- function(x){
  nchar(gsub("[^euoai]","",x))
}
setwd("C:\\Users\\anh\\Downloads\\DSCoursera\\cleaningData\\plyr-tutorial\\examples")
data <- read.csv("./bnames.csv",stringsAsFactors=FALSE)
data <- transform(data,
                  last=letter(name,-1),
                  length=nchar(name),
                  vowels=vowels(name),
                  first=letter(name,1)
                  )
identical(subset(bnames,sex=="boy" & year==2008),bnames[bnames$sex=="boy" & bnames$year==2008,])
one <- subset(bnames,sex=="boy" & year==2008)
one$rank  <- rank(-one$percent,ties.method="first")
one <- transform(bnames,rank=rank(-percent,ties.method="first"))

#Split
pieces <- split(bnames,
                list(bnames$sex,bnames$year))
#Apply
results <- vector("list",length(pieces))
for(i in seq_along(pieces)){
  piece <- pieces[[i]]
  piece <- transform(piece,
                     rank=rank(-percent,ties.method="first"))
  results[[i]] <- piece
}
#Combine
results <- do.call("rbind",results)
#ddply(<table>,<split id column>,<func apply for each group>,<2nd argument for func>) #combine automatically
bnames <- data
bnames <- ddply(bnames,
                c("sex","year"),
                transform,
                rank=rank(-percent,ties.method="first"))
bnames <- ddply(bnames,
                .(sex,year),
                transform,
                rank=rank(-percent,ties.method="first"))
ddply(bnames,c("year","sex"),summarise,tot=sum(percent))
library(ggplot2)
f1 <- ddply(bnames,c("year","sex","first"),summarise,tot=sum(percent))
qplot(year,tot,data=f1,geom="line",colour=sex,facet = ~first)
qplot(year,tot,)


#Another
library(ggplot2)
housing <- read.csv("tx-house-sales.csv")
houston <- subset(housing,city == "Houston")
names(housing)
qplot(date,sales,data=houston,geom="line")
qplot(date,avgprice,data=houston,geom="line")
qplot(date,onmarket,data=houston,geom="line")
want <- function(var, month) {
  resid(lm(var ~ factor(month), na.action = "na.exclude")) + 
    mean(var, na.rm = TRUE)
}
houston <- transform(houston,
                     avgprice_ds = want(avgprice, month),
                     listings_ds = want(listings, month),
                     sales_ds = want(sales, month), 
                     onmarket_ds = want(onmarket, month)
)
avg <- stat_summary(aes(group = 1), fun.y = "mean", geom = "line", 
                    colour = "red", size = 2, na.rm = TRUE)
qplot(month, avgprice_ds, data = houston, geom = "line", group = year) + avg
qplot(date,sales_ds,data=houston,geom="line")
qplot(date,avgprice_ds,data=houston,geom="line")
qplot(date,onmarket_ds,data=houston,geom="line")

