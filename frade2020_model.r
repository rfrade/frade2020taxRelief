#########
# Rafael Aparecido Martins Frade - Central European University
# Replication code for paper: 
#     Does payroll tax relief increase employment level? Evidence from Brazil - 2020
# This script runs the regressions
#########

setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset')
set.seed(123456)
require(data.table)
library(stargazer)

# Descriptive table
firmsNS2010 = fread('firms2010.csv')
firmsNS2011 = fread('firms2011.csv')
firmsNS2012 = fread('firms2012.csv')
firmsNS2013 = fread('firms2013.csv')

summary(firmsNS2013[eligible == 1 & Ind.Simples == 0]$Qtd.Vínculos.CLT)
summary(firmsNS2013[eligible == 0 & Ind.Simples == 0]$Qtd.Vínculos.CLT)
summary(firmsNS2013[eligible == 1 & Ind.Simples == 1]$Qtd.Vínculos.CLT)
summary(firmsNS2013[eligible == 0 & Ind.Simples == 1]$Qtd.Vínculos.CLT)

firmsNS2013[eligible == 1 & Ind.Simples == 0, .N]
firmsNS2013[eligible == 0 & Ind.Simples == 0, .N]
firmsNS2013[eligible == 1 & Ind.Simples == 1, .N]
firmsNS2013[eligible == 0 & Ind.Simples == 1, .N]

# Non-SIMPLES
firmsNS2010 = fread('firms2010.csv')[Ind.Simples == 0]
firmsNS2011 = fread('firms2011.csv')[Ind.Simples == 0]
firmsNS2012 = fread('firms2012.csv')[Ind.Simples == 0]
firmsNS2013 = fread('firms2013.csv')[Ind.Simples == 0]

firmsNS2012$year = 1
firmsModel = rbind(firmsNS2010, firmsNS2011, firmsNS2012)
firmsModel$treated = firmsModel$eligible
modelNS12 = lm(log(Qtd.Vínculos.CLT) ~ year*treated, data = firmsModel)

firmsNS2012$year = 0
firmsModel = rbind(firmsNS2010, firmsNS2011, firmsNS2012, firmsNS2013)
firmsModel$treated = firmsModel$eligible
modelNS13 = lm(log(Qtd.Vínculos.CLT) ~ year*treated, data = firmsModel)

summary(firmsModel)

teste[eligible == 1 & Ind.Simples == 1, .N]
teste[eligible == 1 & Ind.Simples == 0, .N]
teste[eligible == 0 & Ind.Simples == 1, .N]
teste[eligible == 0 & Ind.Simples == 0, .N]

#SIMPLES
firmsS2010 = fread('firms2010.csv')[Qtd.Vínculos.CLT <= 100]
firmsS2011 = fread('firms2011.csv')[Qtd.Vínculos.CLT <= 100]
firmsS2012 = fread('firms2012.csv')[Qtd.Vínculos.CLT <= 100]
firmsS2013 = fread('firms2013.csv')[Qtd.Vínculos.CLT <= 100]

firmsS2012$year = 1
firmsModel = rbind(firmsS2010, firmsS2011, firmsS2012)
firmsModel$treated = as.numeric(!firmsModel$Ind.Simples)
modelSNS12 = lm(log(Qtd.Vínculos.CLT) ~ year*treated, data = firmsModel[eligible == 1])

firmsS2012$year = 0
firmsModel = rbind(firmsS2010, firmsS2011, firmsS2012, firmsS2013)
firmsModel$treated = as.numeric(!firmsModel$Ind.Simples)
modelSNS13 = lm(log(Qtd.Vínculos.CLT) ~ year*treated, data = firmsModel[eligible == 1])

stargazer(modelSNS12, modelSNS13,modelNS12, modelNS13, 
          title = "Diff in Diff results",
          dep.var.labels = "Formal Jobs",
          column.separate = 1,
          column.labels = c("SIMPLES 12", "SIMPLES 13", "Standard 12", "Standard 13"),
          covariate.labels = c(
            "Year", "Treated", "Year.Treated (ATE)", "Intercept"),
          digits = 2,
          df = FALSE)





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
$Qtd.Vínculos.CLT
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

