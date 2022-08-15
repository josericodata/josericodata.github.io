library(ggplot2)
theme_set(theme_classic())

# Source: Frequency table
df <- as.data.frame(df_1)
colnames(df) <- c("Table", "Rows_Number")
pie <- ggplot(df, aes(x = "", y=Rows_Number, fill = factor(df_1$Table))) + 
  geom_bar(width = 1, stat = "identity") +
  theme(axis.line = element_blank(), 
        plot.title = element_text(hjust=0.5)) + 
  labs(fill="Table", 
       x=NULL, 
       y=NULL, 
       title="Records per table in classicmodels DB", 
       caption="Source: classicmodels db")

pie + coord_polar(theta = "y", start=0)

# Source: Categorical variable.
# mpg$class
pie <- ggplot(df$Table, aes(x = "", fill = factor(df_1$Table))) + 
  geom_bar(width = 1) +
  theme(axis.line = element_blank(), 
        plot.title = element_text(hjust=0.5)) + 
  labs(fill="Table", 
       x=NULL, 
       y=NULL, 
       title="Records per table in classicmodels DB", 
       caption="Source: classicmodels db")

pie + coord_polar(theta = "y", start=0)

