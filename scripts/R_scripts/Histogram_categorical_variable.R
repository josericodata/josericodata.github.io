library(RODBC)
library(odbc)
library(DBI)


conn1 <- odbcConnect("MySQL_DNS")



df_3 <-sqlQuery(conn1,"select
productCode,
productName,
productLine,
productVendor
 from classicmodels.products;")


df_3




library(ggplot2)
theme_set(theme_classic())

# Histogram on a Categorical variable
g <- ggplot(df_3, aes(productVendor))
g + geom_bar(aes(fill=productLine), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title="Histogram on Categorical Variable", 
       subtitle="ProductVendor across productLine") 