# Converts treated NCM codes to CNAE codes
fromNCMtoCNAE = function() {
  
  library("readxl")
  require(data.table)
  ncmList = read.table('ncm.txt')
  ncmToCnaeTable = read_excel('NCM2012XCNAE20.xls')
  ncmToCnaeTable = setDT(ncmToCnaeTable)
  setnames(ncmToCnaeTable, "NCM 2012 (AGOSTO)", "ncm")
  setnames(ncmToCnaeTable, "CNAE 2.0", "cnae")
    
  ncmEdited = c(0)# remove dots
  for(i in 1:length(ncmList[,1])) {
    ncmEdited[i] = gsub("\\.", "", ncmList[i,])
  }
  
  cnaeList = c(0)
  k = 1
  count = 1
  while (k <= length(ncmEdited)) {
    # get the NCM row that starts with this prefix and get the respective CNAE 
    prefix = ncmEdited[k]
    prefix = paste("^", prefix, sep="")
    
    nrows = nrow(ncmToCnaeTable[grep(pattern = prefix, x= ncm)])
    if (nrows != 0) {
      cnaeList[count:(nrows+count-1)] = ncmToCnaeTable[grep(pattern = prefix, x= ncm)]$cnae
      count = count + nrows
    }
    k = k + 1
  }
  
  #split items inside same cell
  cnaeListFinal = c(0)
  m = 1
  for(cnae in cnaeList) {
    list = unique(strsplit(split = "\\;", x = cnae)[[1]])
    size = length(list)

    # size maybe greater than 1. Remove dots, -, and trim
    cnaeListFinal[m:(m + size - 1)] = gsub("\\.|-", "", trimws(list))
    m = m + size

  }
  
  #remove duplicates
  return(sort(unique(cnaeListFinal)))
}
