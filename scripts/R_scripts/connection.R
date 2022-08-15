library(RODBC)
library(DBI)
library(odbc)
conn1 <- odbcConnect("MySQL_DNS")
df <-sqlQuery(conn1,'SELECT * FROM employees') #Finally we have got our data frame!!!





