library(RODBC)
library(odbc)
library(DBI)


conn1 <- odbcConnect("MySQL_DNS")


 
df_2 <-sqlQuery(conn1,"SELECT CONCAT(firstName, ',', lastName) AS FIRSTNAME,
                      SUM(quantityOrdered*priceEach) AS totalSales
                      FROM    orderdetails JOIN orders USING (orderNumber)
                      JOIN customers USING (customerNumber)
                      JOIN employees ON
                      customers.salesRepEmployeeNumber = employees.employeeNumber
                      GROUP BY    salesRepEmployeeNumber
                      ORDER BY    totalSales DESC;")


df_2

class(df_2)

library(ggplot2)
theme_set(theme_bw())  

# Data Prep
data(datatable(df_2, rownames = FALSE))  # load data
df_2$RepName <- row.names(df_2)  # create new column for car names
df_2$totalSales_z<- round((df_2$totalSales - mean(df_2$totalSales))/sd(df_2$totalSales), 2)  # compute normalized total sales
df_2$totalSales_type <- ifelse(df_2$totalSales_z < 0, "below", "above")  # above / below avg flag
df_2 <- df_2[order(df_2$totalSales_z), ]  # sort
df_2$RepName  <- factor(df_2$RepName, levels = df_2$RepName)  # convert to factor to retain sorted order in plot.

# Diverging Barcharts
ggplot(df_2, aes(x=RepName, y=totalSales_z, label=totalSales_z),) + 
  geom_bar(stat='identity', aes(fill=totalSales_type), width=.9)  +
  geom_text(aes(label = FIRSTNAME), hjust = 0.1,nudge_y = -.5,colour = "black",fontface="bold") +
  
  scale_fill_manual(name="Total Sales", 
                    labels = c("Above Average", "Below Average"),
                    values = c("above"="#00ba38", "below"="#f8766d")) + 
  labs(subtitle="Normalised total sales for Sales Reps", 
       title= "Diverging Bars") + 
  coord_flip()

