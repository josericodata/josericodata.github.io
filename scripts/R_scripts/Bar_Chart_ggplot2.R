library(ggplot2)
theme_set(theme_classic())

# Plot
g <- ggplot(df_1, aes(Table, Rows_Number))
g + geom_bar(stat="identity", width = 0.5, fill="tomato2") + 
  labs(title="Bar Chart", 
       subtitle="Records per table in classicmodels DB", 
       caption="Source: ") +
  theme(axis.text.x = element_text(angle=65, vjust=0.6))