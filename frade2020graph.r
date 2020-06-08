setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/code/frade2020taxRelief/')
source('subsampling.r')
setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset/')
require(data.table)
library(ggplot2)

theme_set(theme_bw())

#SIMPLES
firms2010 = fread('firms2010.csv')[Qtd.Vínculos.CLT < 100]
firms2011 = fread('firms2011.csv')[Qtd.Vínculos.CLT < 100]
firms2012 = fread('firms2012.csv')[Qtd.Vínculos.CLT < 100]
firms2013 = fread('firms2013.csv')[Qtd.Vínculos.CLT < 100]

firms2010[Ind.Simples == 0 & eligible == 0, .N]
firms2010[Ind.Simples == 1 & eligible == 0, .N]
firms2010[Ind.Simples == 0 & eligible == 1, .N]
firms2010[Ind.Simples == 1 & eligible == 1, .N]

firmsList = list(firms2010, firms2011, firms2012, firms2013)

graphJobsDT = subsampling(firmsList, 1)
ggplot(graphJobsDT, aes(x = j.year)) +
  geom_line(data = graphJobsDT, aes(y = j.simples.eligible, x = j.year, color="red")) +
  geom_line(data = graphJobsDT, aes(y = j.nonsimples.treated, x = j.year, color="blue")) +
  #ggtitle("Evolution of jobs of standard firms (Non-SIMPLES)") +
  xlab("Year") +
  ylab("Number of jobs") +
  theme(legend.position = "bottom") +
  scale_color_discrete(name="",
    labels=c("Standard treated", "SIMPLES of same sectors"))


#Non-SIMPLES
firms2010 = fread('firms2010.csv')
firms2011 = fread('firms2011.csv')
firms2012 = fread('firms2012.csv')
firms2013 = fread('firms2013.csv')

firmsList = list(firms2010, firms2011, firms2012, firms2013)

graphJobsDT = subsampling(firmsList, 30000)

ggplot() +
  geom_line(data = graphJobsDT, aes(y = j.nonsimples, x = j.year, color="red")) +
  geom_line(data = graphJobsDT, aes(y = j.nonsimples.treated, x = j.year, color="blue")) +
  xlab("Year") +
  ylab("Number of jobs") +
  theme(legend.position = "bottom") +
  scale_color_discrete(name="",
       labels=c("Standard firms treated", "Standard firms not affected"))