setwd('/home/rafael/arquivos/mestrado/2_term/metrics_II/paper/dataset')
require(data.table)
source('../code/frade2020taxRelief/translateNCMtoCNAE.r')

cnaeList = as.integer(fromNCMtoCNAE())

# after_treatmend = 1 if year = 2013, 0 otherwise
write_filtered_file = function(table, year, after_treatmend) {
  table = setDT(table) 
  table$eligible = as.numeric(table$CNAE.2.0.Classe %in% cnaeList)
  table = table[Ind.Atividade.Ano == 1, 
            .(Ind.Simples, eligible, Qtd.Vínculos.CLT, CNAE.2.0.Classe)]

  table$year = after_treatmend
  
  name = paste("firms", year, ".csv", sep="")
  write.table(table, name)  
}
table = 
csv2010 = read.csv('ESTB2010.txt', stringsAsFactors=FALSE, fileEncoding="latin1", sep = ';')
write_filtered_file(csv2010, 2010, 0)

csv2011 = read.csv('ESTB2011.txt', stringsAsFactors=FALSE, fileEncoding="latin1", sep = ';')
write_filtered_file(csv2011, 2011, 0)

csv2012 = read.csv('Estb2012.txt', stringsAsFactors=FALSE, fileEncoding="latin1", sep = ';')
write_filtered_file('', 2012, 0)
write_filtered_file('ESTB2013.txt', 2013, 1)

