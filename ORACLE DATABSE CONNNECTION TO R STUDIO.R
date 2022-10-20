#install RODBC PACKAGE

install.packages("RODBC")
library(RODBC)

conn1 <- odbcConnect("DATABASE",uid = "system",pwd = "lion")
summary(conn1)

dataframe <- sqlQuery(conn1,"
SELECT *
FROM system.emp")


View(dataframe)

e<- data.frame(dataframe)
View(e)

d <- sqlQuery(conn1,'select * from dept')
View(d)

#using join funcitons

library(dplyr)

emp_details <- right_join(e,d,by= "DEPTNO")
emp_details1 <- left_join(e,d,by= "DEPTNO")
emp_details2 <- full_join(e,d,by= "DEPTNO")


View(emp_details)
View(emp_details1)
View(emp_details2)

library(ggplot2)

job_sum_sal <- sqlQuery(conn1,"select job,sum(sal)as sal from emp group by job")

View(job_sum_sal)

#Plotting using ggplot2

ggplot(data = job_sum_sal,aes(JOB,SAL, fill=JOB,label = SAL)) + geom_col() + scale_y_continuous(breaks = seq(0, 15000, by = 2500))+
  geom_text(vjust = -0.55,size = 5,position = position_stack(vjust = 0.5))

#closing the odbc

odbcClose(channel= conn1)
