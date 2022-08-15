library(RODBC)
library(DBI)
library(odbc)
conn1 <- odbcConnect("MySQL_DNS")
df1 <-sqlQuery(conn1,'SELECT * FROM employees',stringsAsFactors=F) #Finally we have got our data frame!!!
df1
df#With Factors
df1#Without Factors, datatype for categories.
str(df1)

df
 


conn1 <- odbcConnect("MySQL_DNS") #To retrieve data always run these two together
sqlQuery(conn1,"SELECT * FROM employees")