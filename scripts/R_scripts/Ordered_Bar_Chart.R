library(RODBC)
library(odbc)
library(DBI)


conn1 <- odbcConnect("MySQL_DNS")



df_4 <-sqlQuery(conn1,"SELECT 
                      productName,
                              SUM(quantityOrdered*priceEach) AS totalSales
                      FROM    products JOIN
                              orderdetails USING (productCode)
                      GROUP BY    productCode
                      ORDER BY    totalSales DESC
                                    limit 40;")
df_4
typeof(df_4)


# Prepare data: product name by revenue.
df4_pbr <- aggregate(df_4$totalSales, list(df_4$productName), mean)  # aggregate
colnames(df4_pbr) <- c("productName", "totalSales")  # change column names
df4_pbr  <- df4_pbr[order(df4_pbr$totalSales), ]  # sort
df4_pbr$productName <- factor(df4_pbr$productName , levels = df4_pbr$productName)  # to retain the order in plot.
head(df4_pbr, 4)
library(scales)
library(ggplot2)
theme_set(theme_bw())

# Draw plot
ggplot(df4_pbr, aes(x=productName, y=totalSales)) + 
  geom_bar(stat="identity", width=.5, fill="tomato3") + 
  scale_y_continuous(name="totalSales", labels = comma)+
  labs(title="Ordered Bar Chart", 
       subtitle="Product by Revenue", 
       caption="source: classicmodels db") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))


rm(list)

df4_pbr
