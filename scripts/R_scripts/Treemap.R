library(ggplot2) 
library(treemapify)
library(RODBC) #No need to import every time libraries
library(odbc)
library(DBI)

df_5 <-sqlQuery(conn1,"SELECT
                        productLine, 
                        productCode,
                                SUM(quantityOrdered*priceEach) AS totalSales
                        FROM    products JOIN
                                orderdetails USING (productCode)
                        GROUP BY    productCode
                        ORDER BY    totalSales DESC;")


# plot


  ggplot(df_5, aes(area = totalSales, fill = productLine, label = productCode,subgroup = productLine)) +
    geom_treemap() +
    geom_treemap_subgroup_border(colour = "white", size = 5) +
    geom_treemap_subgroup_text(place = "centre", grow = TRUE,
                               alpha = 0.5, colour = "black",
                               fontface = "italic") +
    geom_treemap_text(colour = "white", place = "centre",
                      size = 15, grow = TRUE)