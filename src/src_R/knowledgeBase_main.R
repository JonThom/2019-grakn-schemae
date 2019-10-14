

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

suppressMessages(library(magrittr))
suppressMessages(library(optparse))
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

stopwords <- strsplit(readChar(con=sprintf("%sstop-word-list.csv", dir_data), nchars=10000), split=",")
stopwords <- as.vector(sapply(stopwords, function(x) gsub(" ", "",x), simplify=T))

#==============================================================================
#============================= INITIALISE =====================================
#==============================================================================

setwd(dir_data)

if (file.exists(dir_project)) {
  load(file=sprintf("%nodes", data_path))
  load(file=sprintf("%adj_semantic.RData", dir_data))
  load(file=sprintf("%adj_semantic_sum.RData", dir_data))
  load(file=sprintf("%adj_episode.RData", dir_data))
  load(file=sprintf("%adj_episode_sum.RData", dir_data))
  load(file=sprintf("%adj_hebb.RData", dir_data))
  load(file=sprintf("%adj_hebb_sum.RData", dir_data))
  load(file=sprintf("%activations.Rdata", dir_data))
  load(file=sprintf("%context.Rdata", dir_data))
  
  # decay the episodic memory adjacency matrix - reduces large values
  adj_episode <- adj_episode %>% decay(lambda = 0.1)
  
  # # normalise the episodic memory adjacency matrix 
  # # adj_episode <- (adj_episode - adj_episode_mean)/adj_episode_sd
  # adj_episode <- softMaxMatrix(adj_episode)
  
  message("Type h() for instructions")
  
  paste0("context:", context)
  
} else {
  nodes = list()
  adj_episode = matrix()
  adj_episode_sum = 0
  adj_semantic = matrix()
  adj_hebb = matrix()
  context = vector(mode="character") 
  activations = numeric()
  message("Type h() for instructions")
}






