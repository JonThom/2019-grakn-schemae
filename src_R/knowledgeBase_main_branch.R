

# Title: KnowledgeBase
# Subtitle: main
# Author: Jonatan Thompson jjt3f2188@gmail.com
# Date: 180325 

#==============================================================================
#============================= DESCRIPTION ====================================
#==============================================================================

## First iteration of a knowledge graph database 
#
# nodes is a list of lists of node attributes
# adjacencies is a positive/negative matrix of distances which is normalised and scaled when called
# activations is a vector with values in [-1,1]
# context is a list of names of recently activated nodes 


#==============================================================================
#================================ USAGE =======================================
#==============================================================================

# e.g.

# time Rscript knowledgeBase_main.R --dir_data "/Users/rkm916/Sync/KnowledgeBase/knowledgeBase_main.R"

#==============================================================================
#============================= LIBRARIES ======================================
#==============================================================================

suppressMessages(library(optparse))
suppressMessages(library(magrittr))
suppressMessages(library(igraph))
suppressMessages(library(data.table))
suppressMessages(library(dplyr))
suppressMessages(library(Matrix))
suppressMessages(library(matrixStats))
suppressMessages(library(rlist))
#suppressMessages(library(parallel))
#suppressMessages(library(readtext))
#suppressMessages(library(igraph))

#==============================================================================
#=============================  OptParse ======================================
#==============================================================================

option_list <- list(
  make_option("--dir_data", type="character", default="/Users/rkm916/Sync/KnowledgeBase/",
              help="Knowledgebase directory")
)

opt <- parse_args(OptionParser(option_list=option_list))

data_path <- opt$dir_data 
if (!file.exists(dir_data)) {
  dir.create(dir_data) 
  print("Data directory not found, new one created")
}

#==============================================================================
#============================== LOAD DATA =====================================
#==============================================================================

source("/Users/rkm916/Sync/KnowledgeBase/knowledgeBase_funcs.R")

#==============================================================================
#============================= INITIALISE =====================================
#==============================================================================

setwd(dir_data)

if (file.exists(dir_project)) {
  
# load(file=sprintf("%nodes", data_path)) #load igraph object

} else {
  
# create igraph object 
 }






