#This file obtains the BLS data and clean it.
payload=list(
  'seriesid'=c('WPU02120301'),
  'catalog'=FALSE,
  'calculations'=TRUE,
  'annualaverage'=TRUE,
  'registrationKey'='b8a34d978df94525ae9d90c150310682')
response <- blsAPI(payload, 2)
json_file <- fromJSON(response)
json_file$Results$series[[1]]$data[[30]]


#This file obtains the BLS data and clean it.
payload=list(
  'seriesid'=c('CUURA207SA0'),
  'catalog'=FALSE,
  'calculations'=TRUE,
  'annualaverage'=TRUE,
  'registrationKey'='b8a34d978df94525ae9d90c150310682')
response <- blsAPI(payload, 2)
json_file <- fromJSON(response)
json_file$Results$series[[1]]$data[[30]]

yit <- c(0.555, 0.536, 0.636, 0.805, 0.778, 0.795)
sum((yit/3)^2)