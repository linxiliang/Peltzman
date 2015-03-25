##############################################################################
#
# Asymmetry of Cost Passthrough - Paltzman Replication
# Xiliang Lin 
#
##############################################################################
#
# Tasks 
# 1. Documents the commodity price pass through
# 2. Analyze the result in the context of a dynamic game. 
#
##############################################################################
#
#Settings
#library(devtools)
#install_github("mikeasilva/blsAPI")
rm(list = ls())
library(data.table)
library(Rcpp)
library(RcppArmadillo)
library(Hmisc)
library(parallel)
library(reshape)
library(ggplot2)
library(numDeriv)
library(blsAPI)
library(rjson)
setNumericRounding(0)
# ------------------------------------------------------------------
#Settings
trial_run   		= TRUE		# Determine the Modules to be run on
run_on_linux            = FALSE         # Determine the Path settings

#  Files and directories -------------------------------------------------------------------------
if (run_on_linux){
  setwd("~/passthrough") # For Linux Server
  input_data_directory  = "data/Movement-Processed"
  #input_data_directory	= "/home/data/Nielsen-Data/Nielsen-Processed-R/RMS/Movement-Processed"
  output_data_directory	= "data/Output-Processed"
  commodity_data_directory = "data/Meta-Processed"
  result_directory        = "results"
} else{
  setwd("D:/cygwin64/home/xlin0/passthrough") # For PC
  input_data_directory	= "data/Movement-Processed"
  output_data_directory	= "data/Output-Processed"
  commodity_data_directory = "data/Meta-Processed"
  result_directory        = "results"
}

#	Filters and sample selection ------------------------------------------------------------------
# Corn
# 1367 Corn Meal
# 1328 Pop Corn Popped
# 1329 Pop Corn Unpopped
# 2608 Corn on Cob
# Wheat
# 1330 SNACKS - PRETZEL
# 1331 PASTA - MACARONI
# 1334 PASTA-SPAGHETTI
# 1349 WHEAT GERM
# 1354 CRACKERS - GRAHAM
# 1393 FLOUR-ALL PURPOSE-WHITE WHEAT
# 1377 FLOUR - ALL PURPOSE - REMAINING

#commodity_module_file = paste(commodity_data_directory, "/commodity-modules.RData", sep="")
commodity_module_file = paste(commodity_data_directory, "/sub-commodity-modules.RData", sep="")
load(commodity_module_file)
if (trial_run) {
  commodity_modules = commodity_modules[8,] #For Testing, Wheat Germ
}

commodity_list = unique(commodity_modules$commodity)
start_week = "2006-01-07"
end_week = "2011-12-31"
#
##############################################################################
#Main Execution of the project
#
#1. include function file
#
source('Peltzman/1-functions.R')
#
#
#2. Include the BLS Data Acquisition and Cleaning File
#
source('Peltzman/2-BLS-Data.R')
#
#3. Data Selection and Processing
#
dma_rank = 50 # Select top dma_rank dmas in terms of total revenue.
chain_rank = 49  # Select top chain_rank chains in terms of total revenue.
upc_rank = 4 # Select top upc_rank products in terms of revenue share.
saturation = 0.8 # The peak of the demand saturate 80% of the market. 
source('codes/3-share-module-1349.R')

# dma_rank = 100 # Select top dma_rank dmas in terms of total revenue.
# chain_rank = 60 # Select top chain_rank chains in terms of total revenue.
# upc_rank = 20 # Select top upc_rank products in terms of revenue share.
# source('codes/3-data-selection-module-1329.R')
#
#4. Run the Log - Linear Demand System.
#source('codes/4-log-regr-module-1349.R')

##############################################################################
