require(data.table)
#Settings
dir <- "D:/cygwin64/home/xlin0/passthrough\data"
indir <- paste(dir, "/data/BLS-PPI", sep="")
outdir <- paste(dir, "/data/BLS-Processed", sep"")


ppi=fread("C:/Users/Xiliang/Downloads/PPICommodityCurrent.txt")
ppi[, series_id:=gsub("\\s", "", series_id)]
plot(ppi[series_id=="WPU02120301"&period!="M13",value], type="l")

PPICITEMS=fread("C:/Users/Xiliang/Downloads/PPICommodityItems.txt")
PPICITEMS[, V4:=NULL]
setnames(PPICITEMS,c("V1","V2","V3"),c("group_code","item_code","item_name"))

PPIIND=fread("C:/Users/Xiliang/Downloads/PPIIndustries.txt", header=FALSE)
PPIIND[, V3:=NULL]
setnames(PPIIND, c("V1", "V2"), c("industry_code","industry_name"))
PPIIND[, digits:=nchar(gsub("-", "", industry_code))]
PPIIND6=PPIIND[digits==6, ]
