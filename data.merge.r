library(plyr)
library(sqldf)
x <- data.frame(id=seq(1:10),
                nameX=sample(letters,size=10))
y <- data.frame(id=5:14,
                nameY=sample(letters,size=10))
plyrLeftJoin <- join(x,y,"id",type="left")
plyrRightJoin <- join(x,y,"id",type="right")
plyrInnerJoin <- join(x,y,"id",type="inner")
plyrFullJoin <- join(x,y,"id",type="full")

sqldfLeftJoin  <- sqldf("select x.id,nameX,nameY from x left join y on x.id=y.id")
identical(sqldfLeftJoin,plyrLeftJoin)
identical(names(sqldfLeftJoin),names(plyrLeftJoin))
cbind(sqldfLeftJoin,plyrLeftJoin)
plyrLeftJoin$