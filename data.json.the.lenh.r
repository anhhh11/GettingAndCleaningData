savehistory("C:/Users/anh/Downloads/DSCoursera/cleaningData/code/data.json.the.lenh.r")
library(jsonlite)
data  <- jsonlite::fromJSON("C:/Users/anh/Downloads/DSCoursera/cleaningData/code/https _api.github.com_users_jtleek_repos.json.txt")
data$created_at[data$name == "datasharing"]
viewRawFileStructure = readLines(file('./wksst8110.for'),n=5)
viewRawFileStructure
wksData<-read.fwf("./wksst8110.for",skip=4,widths=c(10, 9,4, 9,4, 9,4, 9,4))
sum(wksData[4])
savehistory("C:/Users/anh/Downloads/DSCoursera/cleaningData/code/data.json.the.lenh.r")
