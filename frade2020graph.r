setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset/')
require(data.table)
library(ggplot2)
theme_set(theme_bw())

f.simples = numeric(0)
f.nonsimples = numeric(0)
f.simples.eligible = numeric(0)
f.nonsimples.treated = numeric(0)
f.eligible = numeric(0)
f.year = numeric(0)

j.simples = numeric(0)
j.nonsimples = numeric(0)
j.simples.eligible = numeric(0)
j.nonsimples.treated = numeric(0)
j.eligible = numeric(0)
j.year = numeric(0)

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

graphFirmsDT = data.table(f.year,
                          f.simples,
                          f.nonsimples,
                          f.simples.eligible,
                          f.nonsimples.treated,
                          f.eligible)
graphJobsDT = data.table(j.year,
                         j.simples,
                         j.nonsimples,
                         j.simples.eligible,
                         j.nonsimples.treated,
                         j.eligible)

year_t = 2010
for (dtFirm in firmsList) {
  # All Simples
  jobSimples = sum(dtFirm[Ind.Simples == 1, Qtd.Vínculos.CLT])
  firmSimples = dtFirm[Ind.Simples == 1, .N]
  
  # All Non-simples
  jobNSimples = sum(dtFirm[Ind.Simples == 0, Qtd.Vínculos.CLT])
  firmNSimples = dtFirm[Ind.Simples == 0, .N]
  
  # All Simples eligible
  jobEligibleSimples = sum(dtFirm[Ind.Simples == 1 &
                                    eligible == 1, Qtd.Vínculos.CLT])
  firmEligibleSimples = dtFirm[Ind.Simples == 1 & eligible == 1, .N]
  
  # All Non-simples treated
  jobEligibleNSimples = sum(dtFirm[Ind.Simples == 0 &
                                     eligible == 1, Qtd.Vínculos.CLT])
  firmEligibleNSimples = dtFirm[Ind.Simples == 0 &
                                  eligible == 1, .N]
  
  # All eligible
  jobTotalEligible = sum(dtFirm[eligible == 1, Qtd.Vínculos.CLT])
  firmTotalEligible = dtFirm[eligible == 1, .N]
  
  graphJobsDT = rbind(
    graphJobsDT,
    list(
      year_t,
      jobSimples,
      jobNSimples,
      jobEligibleSimples,
      jobEligibleNSimples,
      jobTotalEligible
    )
  )
  
  graphFirmsDT = rbind(
    graphFirmsDT,
    list(
      year_t,
      firmSimples,
      firmNSimples,
      firmEligibleSimples,
      firmEligibleNSimples,
      firmTotalEligible
    )
  )
  
  year_t = year_t + 1
}

ggplot(graphFirmsDT, aes(x = f.year)) +
  geom_line(aes(y = f.simples.eligible), color = 'blue') +
  geom_line(aes(y=f.nonsimples.treated), color = 'red')

ggplot(graphFirmsDT, aes(x = f.year)) +
  geom_line(aes(y = f.nonsimples.treated)) +
  geom_line(aes(y = f.nonsimples))

ggplot(graphFirmsDT, aes(x = f.year)) +
  geom_line(aes(y = f.simples)) +
  geom_line(aes(y = f.nonsimples))
  
ggplot(graphJobsDT, aes(x = j.year)) +
  geom_line(aes(y = j.simples.eligible), color = 'blue') +
  geom_line(aes(y=j.nonsimples.treated), color = 'red')
  
ggplot(graphJobsDT, aes(x = j.year)) +
  geom_line(aes(y = j.nonsimples.treated)) +
  geom_line(aes(y = j.nonsimples))

