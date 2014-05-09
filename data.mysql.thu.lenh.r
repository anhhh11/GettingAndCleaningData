install.packages("Rtools");
install.packages("RMySQL");
ucscDb <- dbConnect(MySQL(),user="genome",
                    host="genome-mysql.cse.ucsc.edu"); #Ket noi
result <- dbGetQuery(ucscDb,"show databases;"); #Truy van truc tiep
dbDisconnect(ucscDb); #Ngat ket noi 
hg19  <- dbConnect(MySQL(),user="genome",
                   host="genome-mysql.cse.ucsc.edu",
                   db="hg19"); #Ket noi toi CSDL xac dinh
allTables  <- dbListTables(hg19); #Liet ke danh sach bang
length(allTables);
dbListFields(hg19,"affyU133Plus2"); #Liet ke danh sach truong
dbGetQuery(hg19,"select count(*) from affyU133Plus2"); #Truy van
affyData <- dbReadTable(hg19,"affyU133Plus2"); #Doc toan bo bang
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3"); #Gui truy van
affyMis <- fetch(query); #Luu truy van vao bo nho
quantile(affyMis$misMatches);
affyMisSmall <- fetch(query,n=10); dbClearResult(query);
dbDisconnect(hg19)