setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset')
require(data.table)
source('../code/translateNCMtoCNAE.r')

estab2012 = read.csv('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset/Estb2012.txt', 
                     stringsAsFactors=FALSE, fileEncoding="latin1", sep = ';')
estab2012 = setDT(estab2012) 

length(estab2012[Ind.Simples == 1 & Qtd.Vínculos.Ativos == 0])
nrow(estab2012[Ind.Simples == 1 & Ind.Atividade.Ano == 1 & Qtd.Vínculos.CLT > 50])
nrow(estab2012[Ind.Simples == 1 & Ind.Atividade.Ano == 1])
nrow(estab2012[Ind.Simples == 0 & Ind.Atividade.Ano == 1 & Qtd.Vínculos.CLT > 50])
nrow(estab2012[Ind.Simples == 0 & Ind.Atividade.Ano == 1])
cnaeList = as.integer(fromNCMtoCNAE())

nrow(estab2012[Ind.Simples == 1 & CNAE.2.0.Classe %chin% cnaeList])
nrow(estab2012[Ind.Simples == 0 & CNAE.2.0.Classe %chin% cnaeList])

estab2012$eligible = as.numeric(estab2012$CNAE.2.0.Classe %in% cnaeList)



Qtd.Vínculos.CLT>100
estab2012$
Ind.Simples == 0/1

















#library(devtools)
#devtools::install_github("lucasmation/microdadosBrasil")
#if linux, install libarchive-dev with apt-get
#devtools::install_github('jimhester/archive') 
#download_sourceData("RAIS", i = "2012")
#unzip_all_7z_rar(root_path = '/home/rafael/2012')

mean(estab2012[Ind.Simples == 0]$Qtd.Vínculos.Ativos)

estab2012[, .(.N), by = .(Ind.Simples)]
cltSimples = estab2012[Qtd.Vínculos.CLT>100, .(quantile(Qtd.Vínculos.CLT, probs = seq(from = 0.1, to = 1, by=0.1))), by = Ind.Simples]

hist(estab2012[Qtd.Vínculos.CLT > 100 & Qtd.Vínculos.CLT < 1000]$Qtd.Vínculos.CLT)

estab2012[Qtd.Vínculos.CLT > 100 & Qtd.Vínculos.CLT < 1000, bins(Qtd.Vínculos.CLT, target.bins = 10), by = Ind.Simples]

estab2012[3, sum(Qtd.Vínculos.CLT), by=CNAE.2.0.Classe]

cnaeList = fromNCMtoCNAE()







d2012 = read_RAIS('vinculos', i = 2012, 
                  root_path = '/home/rafael/2012', UF=c('RR'));

rr12 = read.csv('/home/rafael/2012/RR2012/RR2012.txt', sep = ';', stringsAsFactors=FALSE, fileEncoding="latin1")

rr12 = setDT(rr12)
summary(rr12$Natureza.Jurídica)
library('microdadosBrasil')
