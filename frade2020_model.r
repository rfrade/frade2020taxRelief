#########
# Rafael Aparecido Martins Frade - Central European University
# Replication code for paper: 
#     Does payroll tax relief increase employment level? Evidence from Brazil - 2020
# This script runs the regressions
#########

setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset')
require(data.table)
library(ggplot2)

data2010 = fread('firms2010.csv')
data2011 = fread('firms2011.csv')
data2012 = fread('firms2012.csv')
data2013 = fread('firms2013.csv')


all.simples
all.nsimples
simples.eligible
nsimples.treated
year

firmData = data.table()
jobsData = data.table()

for() {
  
}

graph_data = 
  
ggplot(aes(x = ))