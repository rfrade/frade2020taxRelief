setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset/')
require(data.table)
library(ggplot2)
theme_set(theme_bw())

simples = numeric(0)
nonsimples = numeric(0)
simples.eligible= numeric(0)
nonsimples.treated= numeric(0)
eligible = numeric(0)
year = numeric(0)

firms2010 = fread('firms2010.csv')
firms2010 = firms2010[Qtd.Vínculos.CLT >= 10]
sum(firms2010[Ind.Simples == 0, Qtd.Vínculos.CLT])

firms2011 = fread('firms2011.csv')
firms2011 = firms2011[Qtd.Vínculos.CLT >= 10]

firms2012 = fread('firms2012.csv')
firms2012 = firms2012[Qtd.Vínculos.CLT >= 10]

firms2013 = fread('firms2013.csv')
firms2013 = firms2013[Qtd.Vínculos.CLT >= 10]

firmsList = list(firms2010, firms2011, firms2012, firms2013)

graphFirmsDT = data.table(year= numeric(0), simples, nonsimples, simples.eligible, nonsimples.treated, eligible)
graphJobsDT = data.table(year= numeric(0), simples, nonsimples, simples.eligible, nonsimples.treated, eligible)
year = 2010;

for (dtFirm in firmsList) {
  # All Simples
  jobSimples = sum(dtFirm[Ind.Simples == 1, Qtd.Vínculos.CLT])
  firmSimples = dtFirm[Ind.Simples == 1, .N]
  # All Non-simples
  jobNSimples = sum(dtFirm[Ind.Simples == 0, Qtd.Vínculos.CLT])
  firmNSimples = sum(dtFirm[Ind.Simples == 0, .N])
  # All Simples eligible
  jobEligibleSimples = sum(dtFirm[Ind.Simples == 1 & eligible == 1, Qtd.Vínculos.CLT])
  firmEligibleSimples = dtFirm[Ind.Simples == 1 & eligible == 1, .N]
  # All Non-simples treated
  jobEligibleNSimples = sum(dtFirm[Ind.Simples == 1 & eligible == 1, Qtd.Vínculos.CLT])
  firmEligibleNSimples = dtFirm[Ind.Simples == 1 & eligible == 1, .N]
  
  firmdata.table(year= numeric(0), simples, nonsimples, simples.eligible, nonsimples.treated, eligible)
  eligibleNSimples = dtFirm[Ind.Simples == 0 & eligible == 1, .N]
  # All eligible
  #nEligible = sum(dtFirm[eligible == 1, Qtd.Vínculos.CLT])
  nEligible = sum(dtFirm[eligible == 1, .N])
  
  graphDT = rbind(graphDT, list(year, nSimples, nNSimples, eligibleSimples, eligibleNSimples, nEligible))
  year = year + 1
}

ggplot(graphDT, aes(x = year)) + 
  geom_line(aes(y=simples.eligible), color = '#ff595e') +
#  geom_line(aes(y=simples), color = '#ffca3a') +
#  geom_line(aes(y=nonsimples), color = "red") +
  geom_line(aes(y=nonsimples.treated), color = "blue") +

ggplot(graphDT, aes(x = year)) + 
  geom_line(aes(y=nonsimples.treated)) +
  geom_line(aes(y=nonsimples))
  geom_line(aes(y=simples.eligible), color='red')
