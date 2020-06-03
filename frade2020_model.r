setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset')
require(data.table)
library(ggplot2)

data2010 = fread('firms2010.csv')
data2011 = fread('firms2011.csv')
data2012 = fread('firms2012.csv')
data2013 = fread('firms2013.csv')




graph_data = 
  
ggplot(aes(x = ))