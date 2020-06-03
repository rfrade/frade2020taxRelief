setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset/non-cleaned')
require(data.table)
source('../../code/frade2020taxRelief/translateNCMtoCNAE.r')

cnaeList = as.integer(fromNCMtoCNAE())

# after_treatment = 1 if year = 2013, 0 otherwise
write_filtered_file = function(table, year, after_treatment) {
  table = setDT(table) 
  table$eligible = as.numeric(table$CNAE.2.0.Classe %in% cnaeList)
  table = table[Ind.Atividade.Ano == 1 & Qtd.Vínculos.CLT > 10,
            .(Ind.Simples, eligible, Qtd.Vínculos.CLT, CNAE.2.0.Classe)]

  table$year = after_treatment
  
  name = paste("firms", year, ".csv", sep="")
  write.table(x = table, file = name)  
}

csv2010 = read.csv('ESTB2010.txt', stringsAsFactors=FALSE, fileEncoding="latin1", sep = ';')
print("read 2010")
write_filtered_file(csv2010, 2010, 0)
rm(data = csv2010)

csv2011 = read.csv('ESTB2011.txt', stringsAsFactors=FALSE, fileEncoding="latin1", sep = ';')
print("read 2011")
write_filtered_file(csv2011, 2011, 0)
rm(data = csv2011)

csv2012 = read.csv('Estb2012.txt', stringsAsFactors=FALSE, fileEncoding="latin1", sep = ';')
print("read 2012")
write_filtered_file(csv2012, 2012, 0)
rm(data = csv2012)

csv2013 = read.csv('ESTB2013.txt', stringsAsFactors=FALSE, fileEncoding="latin1", sep = ';')
print("read 2013")
write_filtered_file(csv2013, 2013, 1)
rm(data = csv2013)
