#Tải và thao tác trên bảng CSV
setwd("C:\\Users\\anh\\Downloads\\DSCoursera\\cleaningData\\code") #Chuyển sang thư mục hiện thời
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile='./AmericanCommunitySurvey.csv')
AmericanCommunitySurvey=read.csv('./AmericanCommunitySurvey.csv',header=TRUE)
head(AmericanCommunitySurvey) # 6 dòng đầu
head(AmericanCommunitySurvey,n=2) # 2 dòng đầu
names(AmericanCommunitySurvey) # Tên cột
AmericanCommunitySurvey[c("RT","NR")] # chọn 2 cột
nrow(AmericanCommunitySurvey) # Số dòng
AmericanCommunitySurvey[1,1] ; # Chọn hàng 1 cột 1
AmericanCommunitySurvey[1,] # Chọn cả hàng 1
AmericanCommunitySurvey[2:3,2] # Chọn hàng 2,3 và cột 2
AmericanCommunitySurvey[2:3,] # Chọn hàng 2,3 tất cả các cột
AmericanCommunitySurvey[2:3,3:4] #Chọn vùng gồm hàng 2,3 và cột 3,4
AmericanCommunitySurvey[AmericanCommunitySurvey["RT"]=="H",] # Chọn hàng với điều kiện cột RT bằng H
testFrame=data.frame(a=1:3,b=10:12,nrow=3,ncol=2)  # Tạo bảng dữ liệu 3 hàng, 2 cột
testFrame[testFrame["a"]>1]; # Bảng bị san bằng khi không chọn cột
testFrame[testFrame["a"]>1,]; # Chọn dòng với điều kiện
testFrame[testFrame["a"]>1 & testFrame["b"]==11,] # Chọn dòng nhiều điều kiện
testFrame[4] = c(4,15,NA,NA) #Gán giá trị cho cột thứ 4 từ trái sang
testFrame['c'] =  testFrame['a']+testFrame['b'] #Tạo cột mới
testFrame['d'] = c(10,NA,NA,NA) #Gán giá trị cho cột
names(testFrame) = c("a","b","c","d","e","f") #Gán tên cho cột
row.names(testFrame) # Tên hàng
testFrame[1,] = c(1,2,3,4,5,6) #Gán giá trị cho hàng
nrow(testFrame) # Số hàng
ncol(testFrame) # Số cột
testFrame[,1] # Chọn cột 1
cbind(testFrame,c(1,1,1,1,1,1)) #Tạo bảng mới có thêm 1 cột
rbind(testFrame,c(1,1,1,1,1,1)) #Tạo bảng mới có thêm 1 hàng
testFrame[5,]=seq(6)
na.omit(testFrame) #Loại bỏ các hàng mà cột bất kì có giá trị NA
testFrame[2,3:5]=NA
na.omit(testFrame[c('a','d')])
testFrame[is.na(testFrame)] = 0 #Gán các giá trị NA trong bảng bằng 0
testFrame[2:3,c('d','e')] = matrix(data=seq(4))
#Data table
AmericanCommunitySurvey = data.table(AmericanCommunitySurvey) #Chuyển sang data.table
tables() #Xem kích thước bảng trong bộ nhớ
AmericanCommunitySurvey = fread('AmericanCommunitySurvey.csv',header=TRUE) #Đọc nhanh bảng
head(AmericanCommunitySurvey) 
names(AmericanCommunitySurvey)
#Cấu trúc AmericanCommunitySurvey[<DS các hàng chọn>,<DS các cột chọn>,<Gom nhóm>] == AmericanCommunitySurvey[where,select,groupby]
AmericanCommunitySurvey[1] #Chọn hàng 1
AmericanCommunitySurvey[1,RT] #Chọn hàng 1 và hiển thị cột RT
AmericanCommunitySurvey[1,list(RT,SERIALNO)] #Chọn hàng 1 và hiển thị 2 cột RT và SERIALNO
nrow(AmericanCommunitySurvey)
ncol(AmericanCommunitySurvey)
AmericanCommunitySurvey[2:3,SERIALNO] #Chọn hàng 2,3 hiển thị cột SERIALNO
AmericanCommunitySurvey[1,] #Chọn hàng 1 và tất cả cột
testFrame = data.table(testFrame)
testFrame[a>1,] #Chọn với điều kiện
testFrame[a>1,a]
testFrame[a>1 & b==11,a]
testFrame[c(FALSE,TRUE)] #Chọn phần từ ở hàng chẵn
testFrame[,b]
#with=FALSE chọn bằng số hiệu vị trí cột và tên cột (đặt trong dấu '')
testFrame[,2,with=FALSE]
testFrame[,'b',with=FALSE]
setkey(testFrame,b) #Indexing cột b
testFrame[b==1]
setkey(AmericanCommunitySurvey,RT)
AmericanCommunitySurvey["H"]
AmericanCommunitySurvey[,sum(SERIALNO),by=PUMA]
setkey(AmericanCommunitySurvey,PUMA,REGION)
#Dùng c(..) thì danh sách cột trong dấu '', dùng list thì không cần
AmericanCommunitySurvey[,sum(SERIALNO),by=key(AmericanCommunitySurvey)]
AmericanCommunitySurvey[,sum(SERIALNO),by=c("PUMA","REGION")]
setkey(testFrame,b)
#Chọn cột giá trị b==1, và hiển thị kết quả cột d+e ( nhanh hơn so với testFrame[b==1,d+e] nhưng yêu cầu setkey với b trước đó)
testFrame[J(1),d+e]
AmericanCommunitySurvey[,sum(SERIALNO),by=PUMA]
AmericanCommunitySurvey[,list(min=min(SERIALNO),sum(SERIALNO),max=max(SERIALNO)),by=c("PUMA","REGION")]
key(AmericanCommunitySurvey)
setkey(AmericanCommunitySurvey,PUMA)
AmericanCommunitySurvey[,list(min=lapply(.SD[,SERIALNO],min)),by=PUMA]
AmericanCommunitySurvey[,sum(SERIALNO),by=PUMA]
AmericanCommunitySurvey[,sum(SERIALNO),by=PUMA][V1] # Kết quả trả về là 1 bảng khác nên chain được
AmericanCommunitySurvey[,sum(SERIALNO),by=PUMA][,V1]
a=AmericanCommunitySurvey[,sum(SERIALNO),by=PUMA][order(V1)] #Sắp xếp tăng dần theo cột kết quả V1
descendingOrder=AmericanCommunitySurvey[,sum(SERIALNO),by=PUMA][order(-V1)] # Sx giảm dần
