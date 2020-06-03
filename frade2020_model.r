#########
# Rafael Aparecido Martins Frade - Central European University
# Replication code for paper: 
#     Does payroll tax relief increase employment level? Evidence from Brazil - 2020
# This script runs the regressions
#########

setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset')
require(data.table)

data2010 = fread('firms2010.csv')
#data2010 = data2010[Qtd.Vínculos.CLT > 20]
data2011 = fread('firms2011.csv')
#data2011 = data2011[Qtd.Vínculos.CLT > 20]
data2012 = fread('firms2012.csv')
#data2012 = data2012[Qtd.Vínculos.CLT > 20]
data2013 = fread('firms2013.csv')
#data2013 = data2013[Qtd.Vínculos.CLT > 20]

dataReg = rbind(data2010, data2011, data2012, data2013)

dataReg$treated = dataReg$eligible*(as.numeric(!dataReg$Ind.Simples))
dataReg$year_treated = dataReg$year*dataReg$treated

model = lm(log(Qtd.Vínculos.CLT) ~ year + treated + year_treated, data = dataReg)
summary(model)
