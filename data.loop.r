m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
#Dùng hàm mean với mỗi dòng của m
#1: là chiều dòng, 2: là chiều cột
apply(m,1,mean)
#Theo cột
apply(m,2,mean)
#Theo cả dòng, cả cột
apply(m,1:2,function(x) x/2) #Chỉ mang tính minh họa
m/2 #Dùng cách này ngắn gọn hơn + nhanh hơn nhiều

d=data.frame(a=rep(1:10,10),b=rnorm(10),c=rnorm(10))
#by(<cột dữ liệu dùng trong gặt>,<khóa gom nhóm>,<hàm gặt>)
#== select <hàm gặt>(<nhóm đã gom>) from <dữ liệu> group by <khóa gom nhóm>
byResult <- by(data=d[c("b","c")],d$a,colMeans)

e <- new.env()
e$a  <- 1:10
e$b <- 2:10
eapply(e,mean)

#lapply
l <- list(a = 1:10, b = 11:20)
lapply(l, mean)
lapply(l, sum)
#sapply: cải tiến lapply trả về veto hoặ matrix nếu thích hợp
sapply(l, mean)
class(sapply(l, sum))
#Vapply: trả về array và cho phép đặt trước tên cột, biến
l.mean <- vapply(l,max,c(Max.=0))
#Lặp
replicate(2,rnorm(3))


#mapply
l1 <- list(a = c(1:10), b = c(11:20))
l2 <- list(c = c(21:30), d = c(31:40))
mapply(sum, l1$a, l1$b, l2$c, l2$d)

#rapply = lapply | sapply
l <- list(a = 1:10, b = 11:20)
class(rapply(l, log2))
class(rapply(l, log2, how = "list"))
class(rapply(l, mean))
class(rapply(l, mean, how = "list"))

#apply by tag
tapply(l,1:2,function(x) mean(x[[1]]))
