#########
# Rafael Aparecido Martins Frade - Central European University
# Replication code for paper: 
#     Does payroll tax relief increase employment level? Evidence from Brazil - 2020
# This script runs the regressions
#########

setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset')
set.seed(123456)
require(data.table)

firms2010 = fread('firms2010.csv')
firms2010 = firms2010[((Qtd.Vínculos.CLT <= 100 & Ind.Simples == 1) | (Qtd.Vínculos.CLT <= 100 & Ind.Simples == 0))]

firms2011 = fread('firms2011.csv')
firms2011 = firms2011[((Qtd.Vínculos.CLT <= 100 & Ind.Simples == 1) | (Qtd.Vínculos.CLT <= 100 & Ind.Simples == 0))]

firms2012 = fread('firms2012.csv')
firms2012 = firms2012[((Qtd.Vínculos.CLT <= 100 & Ind.Simples == 1) | (Qtd.Vínculos.CLT <= 100 & Ind.Simples == 0))]
firms2012$year = 1

firms2013 = fread('firms2013.csv')
firms2013 = firms2013[((Qtd.Vínculos.CLT <= 100 & Ind.Simples == 1) | (Qtd.Vínculos.CLT <= 100 & Ind.Simples == 0))]

firmsList = rbind(firms2011, firms2012)
nrow(firmsList)

firmsList$treated = firmsList$eligible*(as.numeric(!firmsList$Ind.Simples))
firmsList$year_treated = firmsList$year*firmsList$treated

model = lm(log(Qtd.Vínculos.CLT) ~ year*treated, data = firmsList)
summary(model)

plot(log(firmsList$Qtd.Vínculos.CLT), firmsList$year_treated)


get_firms_list = function(firms) {
  firms = firms[((Qtd.Vínculos.CLT > 100 & Ind.Simples == 1) | (Qtd.Vínculos.CLT > 100 & Ind.Simples == 0))]
  #eligible = firms[eligible == 1][sample(.N, 15000, replace=TRUE)]
  #subsamples = firms[eligible == 0][sample(.N, 15000, replace=TRUE)]
  #firms = rbind(eligible, subsamples)
  
  return(firms)  
}

firms2010 = get_firms_list(fread('firms2010.csv'))
firms2011 = get_firms_list(fread('firms2011.csv'))
firms2012 = get_firms_list(fread('firms2012.csv'))
firms2012$year = 1
firms2013 = get_firms_list(fread('firms2013.csv'))

firmsModel = rbind(firms2010, firms2011, firms2012, firms2013)


model = lm(log(Qtd.Vínculos.CLT) ~ year*eligible, data = firmsModel[Ind.Simples == 0])
summary(model)
firmsModel[eligible == 0,.N]




data2011 = fread('firms2011.csv')
groups2011NS = data2011[eligible == 1 & Ind.Simples == 0 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]
groups2011Simples = data2011[eligible == 1 & Ind.Simples == 1 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]

data2012 = fread('firms2012.csv')
data2012$year = 1
groups2012NS = data2012[eligible == 1 & Ind.Simples == 0 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]
groups2012Simples = data2012[eligible == 1 & Ind.Simples == 1 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]

data2013 = fread('firms2013.csv')
groups2013NS = data2013[eligible == 1 & Ind.Simples == 0 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]
groups2013Simples = data2013[eligible == 1 & Ind.Simples == 1 ,sum(Qtd.Vínculos.CLT), by = CNAE.2.0.Classe]

differenceFirmsSimples1211 = numeric(0)
differenceFirmsNSimples1211 = numeric(0)

differenceFirmsSimples1312 = numeric(0)
differenceFirmsNSimples1312 = numeric(0)

for (index in 1:154) {
  
  cnae = groups2012Simples[index]$CNAE.2.0.Classe
  
  firmsSimples2011 = groups2011Simples[CNAE.2.0.Classe == cnae]$V1
  firmsSimples2012 = groups2012Simples[CNAE.2.0.Classe == cnae]$V1
  firmsSimples2013 = groups2013Simples[CNAE.2.0.Classe == cnae]$V1

  firmsNSimples2011 = groups2011NS[CNAE.2.0.Classe == cnae]$V1
  firmsNSimples2012 = groups2012NS[CNAE.2.0.Classe == cnae]$V1
  firmsNSimples2013 = groups2013NS[CNAE.2.0.Classe == cnae]$V1

  differenceFirmsSimples1211[index] = firmsSimples2012 - firmsSimples2011
  differenceFirmsNSimples1211[index] = firmsNSimples2012 - firmsNSimples2011

  differenceFirmsSimples1312[index] = firmsSimples2013 - firmsSimples2012
  differenceFirmsNSimples1312[index] = firmsNSimples2013 - firmsNSimples2012
  print(paste(cnae, ))
}

printQtt = function(cnae, diffS1211, diffNS1211, diffS1312, diffNS1312) {
  
}

sum(differenceFirmsNSimples1211[1:152])
sum(differenceFirmsSimples1211[1:152])
sum(differenceFirmsNSimples1312[1:151])
sum(differenceFirmsSimples1312[1:151])


diffNS1211 = data.frame(jobs = differenceFirmsNSimples1211, year = 0, simples = 0)
diffS1211 =  data.frame(jobs = differenceFirmsSimples1211, year = 0, simples = 1)

diffNS1312 = data.frame(jobs = differenceFirmsNSimples1312, year = 1, simples = 0)
diffS1312 =  data.frame(jobs = differenceFirmsSimples1312, year = 1, simples = 1)

diffData = rbind(diffNS1211, diffS1211, diffNS1312, diffS1312)
diffData$eligible = as.numeric(!diffData$simples)
diffData$year_treated = diffData$treated*diffData$year

modelDiff = lm(log(jobs) ~ eligible*year, data = diffData)
summary(modelDiff)

