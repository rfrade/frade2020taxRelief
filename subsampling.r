

subsampling = function(firmsList, sample_size) {
  
  graphJobsDT = graph_datatable()
  
  year_t = 2010

  for (dtFirm in firmsList) {
    # All Simples
    jobSimples = 
    #firmSimples = subsample(dtFirm[Ind.Simples == 1, .N])
    
    # All Non-simples
    jobNSimples = mean(subsample(dtFirm[Ind.Simples == 0, Qtd.Vínculos.CLT], sample_size))
    #firmNSimples = dtFirm[Ind.Simples == 0, .N]
    
    # All Simples eligible
    jobEligibleSimples = sum(dtFirm[Ind.Simples == 1 &
                                                 eligible == 1, Qtd.Vínculos.CLT], sample_size)
    #firmEligibleSimples = dtFirm[Ind.Simples == 1 & eligible == 1, .N]
    
    # All Non-simples treated
    jobEligibleNSimples = sum(dtFirm[Ind.Simples == 0 &
                                                  eligible == 1, Qtd.Vínculos.CLT], sample_size)
    #firmEligibleNSimples = dtFirm[Ind.Simples == 0 &
    #                                eligible == 1, .N]
    
    # All eligible
    jobTotalEligible = sum(dtFirm[eligible == 1, Qtd.Vínculos.CLT], sample_size)
    #firmTotalEligible = dtFirm[eligible == 1, .N]
    
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
    
    year_t = year_t + 1
  }
  return(graphJobsDT)
}

subsample = function(datatable, size) {
  data = numeric(0)
  for (i in 1:1000) {
    data[i] = sum(sample(datatable, size, replace = TRUE))
  }
  return(data)
}

graph_datatable = function() {
  j.simples = numeric(0)
  j.nonsimples = numeric(0)
  j.simples.eligible = numeric(0)
  j.nonsimples.treated = numeric(0)
  j.eligible = numeric(0)
  j.year = numeric(0)
  
  graphJobsDT = data.table(j.year,
                           j.simples,
                           j.nonsimples,
                           j.simples.eligible,
                           j.nonsimples.treated,
                           j.eligible)
  return(graphJobsDT)
}