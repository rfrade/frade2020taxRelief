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
data2012$year = 0
groups2012NS = data2012[eligible == 1 & Ind.Simples == 0 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]
groups2012Simples = data2012[eligible == 1 & Ind.Simples == 1 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]

#data2012 = data2012[Qtd.Vínculos.CLT > 20]
data2013 = fread('firms2013.csv')
groups2013NS = data2013[eligible == 1 & Ind.Simples == 0 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]
groups2013Simples = data2013[eligible == 1 & Ind.Simples == 1 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]

groups2013Simples[.(V1, CNAE.2.0.Classe), order(CNAE.2.0.Classe)]
groups2012Simples[, sort(CNAE.2.0.Classe)]

#data2013 = data2013[Qtd.Vínculos.CLT > 20]

dataReg = rbind(data2010, data2011, data2012, data2013)

dataReg$treated = dataReg$eligible*(as.numeric(!dataReg$Ind.Simples))
dataReg$year_treated = dataReg$year*dataReg$treated

model = lm(log(Qtd.Vínculos.CLT) ~ year + treated + year_treated, data = dataReg)
summary(model)








data2011 = fread('firms2011.csv')
groups2011NS = data2011[eligible == 1 & Ind.Simples == 0 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]
groups2011Simples = data2011[eligible == 1 & Ind.Simples == 1 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]


data2012 = fread('firms2012.csv')
data2012$year = 1
groups2012NS = data2012[eligible == 1 & Ind.Simples == 0 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]
groups2012Simples = data2012[eligible == 1 & Ind.Simples == 1 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]

differenceFirmsSimples = numeric(0)
differenceFirmsNSimples = numeric(0)
for (index in 1:154) {
  
  cnae = groups2012Simples[index]$CNAE.2.0.Classe
  
  firmsSimples2011 = groups2011Simples[CNAE.2.0.Classe == cnae]$V1
  firmsSimples2012 = groups2012Simples[CNAE.2.0.Classe == cnae]$V1

  firmsNSimples2011 = groups2011NS[CNAE.2.0.Classe == cnae]$V1
  firmsNSimples2012 = groups2012NS[CNAE.2.0.Classe == cnae]$V1

  differenceFirmsSimples[index] = firmsSimples2011 - firmsSimples2012
  differenceFirmsNSimples[index] = firmsNSimples2012 - firmsNSimples2011
}

sum(differenceFirmsNSimples[1:152])
sum(differenceFirmsSimples[1:152])

#data2012 = data2012[Qtd.Vínculos.CLT > 20]
data2013 = fread('firms2013.csv')
groups2013NS = data2013[eligible == 1 & Ind.Simples == 0 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]
groups2013Simples = data2013[eligible == 1 & Ind.Simples == 1 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]

groups2013Simples[.(V1, CNAE.2.0.Classe), order(CNAE.2.0.Classe)]
groups2012Simples[, sort(CNAE.2.0.Classe)]


