setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset')
require(data.table)

dados2010 = fread('firms2010.csv')
dados2011 = fread('firms2011.csv')
dados2012 = fread('firms2012.csv')
dados2013 = fread('firms2013.csv')

dados2010[]

ggplot2::