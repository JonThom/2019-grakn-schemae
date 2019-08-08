
# Title: KnowledgeBase
# Subtitle: function and constants
# Author: Jonatan Thompson jjt3f2188@gmail.com
# Date: 180325 


#==============================================================================
#============================= USER FUNCTIONS =================================
#==============================================================================

commit = function(name, file=NULL, tags=NULL, body=NULL) {
  # args:
  #   name
  #   nodes
  #   file
  #   tags
  # return: 
  # usage: 
  #   > c(nodes, "birdwatcher", tags=c("ornithology", "animals", "science"))
  #   "birdwatcher" cted
  #   
  # for Robjects - string, number
  # if input is a character object, make that the title
  # if input is a list, parse it to get title, body
  # if input is a directory, read it in 
  # if input is a data.frame..
  #
  # Out: 
  
  # if (name %in% names(nodes)) {
  #   stop("Node name already exists")
  # }

  # Extract words as body
  body <- if (is.null(file)) NULL else file %>% readtext() %>% clean_split_filter()
  
  node <- list("name" = name,
              "file" = file,
              "created" = as.numeric(Sys.time()), 
              "type"= if (is.null(file)) "concept" else "resource",
              "tags" = tags,
              "body" = body)
  
  if (length(nodes) < 1) { # first node
    adj_semantic = matrix(c(0))
    adj_episode = matrix(c(0))
    adj_hebb = matrix(c(0))
  } else {
    # Add edges to the adjacency matrices
    add_edges(adj_semantic, node, nodes, weightFnc_semantic) # weights are stable
    add_edges(adj_episode, node, nodes, weightFnc_episode) # weights decay slowly
    add_edges(adj_hebb, node, nodes, NULL) # weights update below and then each time user calls cn()
  }
  
  # # Update mean and sd of semantic and episode adj matrices
  # adj_semantic_mean = matrixStats::mean2(adj_semantic, na.rm = T)
  # adj_semantic_sd = sd(adj_semantic, na.rm = T)
  # adj_episode_mean = matrixStats::mean2(adj_episode, na.rm = T)
  # adj_episode_sd = sd(adj_episode, na.rm = T)
   
  # Add the node to the list of nodes and name it
  nodes <- list.append(nodes,node) 
  names(nodes)[[length(nodes)]] <- name 
 
  # Add the node to the list of nodes and name it
  for (adj in c(adj_semantic, adj_episode)) {  
    rownames(adj) = names(nodes)
    colnames(adj) = names(nodes)
  }
  
  # Add a position to the activations vector
  activations <- c(activations, c(0))
  names(activations)[[length(activations)]] <- name
  
  # cn to note 
  cn(node$name)
}

cn = function(node_names) {
  # 'current node', analogous to 'current directory'. Activates the node and neighours recursively
  # TODO: if (context==T) { # do not ignore context } else {activate based on current node weights, not activation. }
  
  # if a node doesn't exist commit it
  for (name in node_names) {
    if (!name %in% names(nodes)) commit(name) # if the cn name isn't committed, commit it now
  }
  
  # add new nodes to context vector
  for (name in node_names){
    context <- c(name, context)
  }
  
  if (length(nodes)>1) {
    # update context adjacency weights
    for (node in node_names) {
      j = grep(node, names(nodes)) # get index of node
      for (i in 1:length(nodes)) {
      adj_hebb[i,j] <- if (i!=j) weightFnc_hebb(i,j, context) else 0.0 # diagonal
      adj_hebb[j,i] <- adj_hebb[i,j] # context adjacency matrix is symmetric 
      }
    }
    
    
    # # normalise hebbian adjacency matrix
    # adj_hebb_mean <- matrixStats:mean2(adj_hebb, refine = F, na.rm = T)
    # adj_hebb_sd <- sd(x, na.rm = T)
    # adj_hebb <- (adj_hebb - adj_hebb_mean)/adj_hebb_sd 
  
    # Compute a temporary single adjacency matrix with normalised and scaled values
    adj_tmp = (softMaxMatrix(adj_episode) + softMaxMatrix(adj_semantic) + softMaxMatrix(adj_hebb))/3.0
    
    # activate nodes and neighbours recurrently
    for (node in nodes_names) {
      x = grep(node, names(nodes))
      activations[x] = 1
      activate(i=x,j=x, nodes, dj_tmp, activations) # first call activate with the node activating itself,  
      # then set off a recurrent call to other nodes
    }
  } 
  
  # view node and highly activated nodes
  display_active(nodes, activations) 
  
  # decay node activations and the weights of hebbian adjacency matrix
  activations <- activations %>% decay(lambda=0.1)
  adj_hebb <- adj_hebb %>% decay(lambda=0.1) 
}

clc = function() {
  # Clear context
  activations <- numeric(length(activations))
}

s = function() {
  save(adj_semantic, file=sprintf("%sadj_semantic.RData", data_dir))
  save(adj_episode, file=sprintf("%sadj_episode.RData", data_dir))
  save(adj_hebb, file=sprintf("%sadj_hebb.RData", data_dir))
  save(activations, file=sprintf("%activations.Rdata", data_dir))
}


#==============================================================================
#========================== UTILITY FUNCTIONS =================================
#==============================================================================

activate = function(i, j, 
                    nodes, 
                    adj,
                    activations) {
  # j activates i
  if (activations[j] > 0.5) activations[i] = activations[i] + adj[i,j]
  # i recurrently activates its neighbours
  if (activations[i] > 0.5) {
    for (h in adj[,i][abs(adj[,i])>0.2]) {
      activate(h, i, nodes, adj, activations)
    }
  }  
}

add_edges = function(adj, node, nodes, weightFnc) {
  # Subroutine called by commit()
  # Args: 
  #   adj: non-normalised adjacency matrix
  #   note: node to be added
  #   weightFnc: function to evaluate to set edge weight
  
  if (!is.null(weightFnc)) {
    weights_i_node <- sapply(nodes, function(i) weightFnc(i, node)) # vector of weighted edges out
    weights_node_j <- sapply(nodes, function(i) weightFnc(node, i)) # vector of weighted edges in 
  } else {
    weights_i_node <- numeric(length(nodes))
    weights_node_j <- numeric(length(nodes))
  }
  # bind column of edges out and row of edges in plus diagonal entry
  adj <- adj %>% cbind(weights_i_node) %>% rbind(c(weights_node_j,0)) 
  
  return(adj)
}

clean_split_filter = function(x) {
  # Todo: add documentation and make it searchable
  # Usage: 
  # args: 
  # returns
  y <- gsub(" ", "ASPACEHERE",x)
  y <- gsub("[^a-z]", "", y,  ignore.case=T)
  y <- strsplit(y, "ASPACEHERE") 
  y <- unlist(y)
  y <- y[!y %in% stopwords]
  return(y)
}

context_score = function(idx) {
  # idx is an index on the context vector 
  score <- exp(-idx*0.1)
}

decay = function(x,lambda=0.1) {
  # decay positive or negative number towards 0 at rate lambda
  x <- x+(0-x)*lambda
}

display_active = function(nodes, activations) {
  mostActive <- nodes[order(activations)][0:min(length(nodes),20)]
  message("Active:")
  for (node in mostActive) {
    message(paste0(node$name, " - file: ", node$file, " - tags: ", paste(node$tags, ", ", sep="", collapse="")))
  }
}

h = function() {
  # Display help information
  message("usage:")
  message("commit(name, nodes=nodes,file=NULL, tags=NULL, activations=activations): commit name as node")
  message("cn(node_names, context = T): make node_name the current node")
  message("clc(): clear context")
  message("s(): save")
  message("h(): help")
}

read_file = function(path) {
  # Read in a file or webpage
  readtext()
  list_of_string = list() 
  # TODO read in file
  # TODO break string up
  return(list_of_string)
}

softMaxMatrix = function(m) {
  # This function normalises, scales to [-1;1] and rounds the values of a real-valued matrix
  num <- exp(m)
  denom <- sum(rowSums(apply(m, MARGIN=c(1,2), FUN=exp)))
  return(round((num/denom)*2-1,1)) # scale to [-1;1] and round to 1 decimal
}

weightFnc_episode = function(node_i,node_j) {
  # Args: i,j: nodes: lists of attributes. Edge from j to i.
  # TODO: scale the exponential
  (node_i$created-node_j$created)/3600 %>% -abs() %>% exp()
}

weightFnc_semantic = function(node_i,node_j) {
  # weight of directed edge from j to i (notation as in Newman 2010 p. 114)
  # For now, the idea is that if node j has fewer words than i, j can be more 
  # correlated with i than i with j, but i can have correlations with more others.
  # TODO:  replace with a paragraph2vec or word2vec embedding
  weight_body <- if (is.null(node_i$body) | is.null(node_j$body)) 0 else length(intersect(node_j$body,node_i$body))/length(node_j$body)
  weight_tags <- length(intersect(node_j$tags, node_i$tags))/length(node_j$tags)
  return(weight_body + weight_tags)
}

weightFnc_hebb = function(i,j, context) {
  # Edge from j to i.
  sumScore_i <- sapply(grep(i, context), context_score, simplify = T) %>% sum(na.rm = T)
  sumScore_j <- sapply(grep(j, context), context_score, simplify = T) %>% sum(na.rm = T)
  return(min(sumScore_i, sumScore_j))
}

#==============================================================================



#==============================================================================
