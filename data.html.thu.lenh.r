googlePage = url("https://www.google.com.vn/")
googlePageContent = readLines(googlePage)
close(googlePage)
library(XML)
url <- "http://www.tech24.vn/"
html  <- htmlTreeParse(url,useInternalNodes=TRUE)
xpathApply(html,"//title",xmlValue)
#RESTful support
library(httr)
html2 <- GET(url)
#content2 <- content(html2,as="parsed")
content2 <- content(html2,as="text")
content2 <- htmlParse(content2,asText=TRUE)
xpathSApply(content2,"//title",xmlValue)
pg1=GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
google=handle("http://google.com")
