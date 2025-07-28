## ----Load packages - quick start, eval=TRUE, message=FALSE--------------------
#--- Load required packages for this section
library(igraph)
library(ggplot2)
library(RGraphSpace)
library(PathwaySpace)

## ----Making a toy igraph - 1, eval=TRUE, message=FALSE------------------------
# Make a 'toy' igraph object, either a directed or undirected graph
gtoy1 <- make_star(5, mode="undirected")

# Assign 'x' and 'y' coordinates to each vertex
# ..this can be an arbitrary unit in (-Inf, +Inf)
V(gtoy1)$x <- c(0, 2, -2, -4, -8)
V(gtoy1)$y <- c(0, 0,  2, -4,  0)

# Assign a 'name' to each vertex (here, from n1 to n5)
V(gtoy1)$name <- paste0("n", 1:5)

## ----GraphSpace constructor - 1, eval=TRUE, message=FALSE---------------------
# Check graph validity
g_space1 <- GraphSpace(gtoy1, mar = 0.2)

## ----GraphSpace constructor - 2, eval=FALSE, message=FALSE, out.width="100%"----
# # Check the graph layout
# plotGraphSpace(g_space1, add.labels = TRUE)

## ----PathwaySpace constructor - 1, eval=TRUE, message=FALSE-------------------
# Run the PathwaySpace constructor
p_space1 <- buildPathwaySpace(g_space1)

## ----PathwaySpace constructor - 2, eval=TRUE, message=FALSE, results='hide'----
# Check the number of vertices in the PathwaySpace object
length(p_space1)
## [1] 5

# Check vertex names
names(p_space1)
## [1] "n1" "n2" "n3" "n4" "n5"

# Check signal (initialized with '0')
vertexSignal(p_space1)
## n1 n2 n3 n4 n5 
##  0  0  0  0  0

## ----PathwaySpace constructor - 3, eval=TRUE, message=FALSE, results='hide'----
# Set new signal to all vertices
vertexSignal(p_space1) <- c(1, 4, 2, 4, 3)

# Set a new signal to the 1st vertex
vertexSignal(p_space1)[1] <- 2

# Set a new signal to vertex "n1"
vertexSignal(p_space1)["n1"] <- 6

# Check updated signal values
vertexSignal(p_space1)
## n1 n2 n3 n4 n5 
##  6  4  2  4  3

## ----Circular projection - 1, eval=FALSE, message=FALSE, out.width="70%"------
# # Run signal projection
# p_space1 <- circularProjection(p_space1, k = 1, pdist = 0.4)
# 
# # Plot a PathwaySpace image
# plotPathwaySpace(p_space1, add.marks = TRUE)

## ----Circular projection - 2, eval=FALSE, message=FALSE, out.width="70%"------
# # Re-run signal projection with 'k = 2'
# p_space1 <- circularProjection(p_space1, k = 2, pdist = 0.4)
# 
# # Plot the PathwaySpace image
# plotPathwaySpace(p_space1, marks = c("n3","n4"), theme = "th2")

## ----Circular projection - 3, eval=FALSE, message=FALSE, out.width="70%"------
# # Re-run signal projection, adjusting Weibull's shape
# p_space1 <- circularProjection(p_space1, k = 2, pdist = 0.2,
#   decay.fun = signalDecay(shape = 2))
# 
# # Plot the PathwaySpace image
# plotPathwaySpace(p_space1, marks = "n1", theme = "th2")

## ----Polar projection - 1, eval=TRUE, message=FALSE, out.width="100%"---------
# Load a pre-processed directed igraph object
data("gtoy2", package = "RGraphSpace")
# Check graph validity
g_space2 <- GraphSpace(gtoy2, mar = 0.2)

## ----Polar projection - 2, eval=FALSE, message=FALSE, out.width="100%"--------
# # Check the graph layout
# plotGraphSpace(g_space2, add.labels = TRUE)

## ----Polar projection - 3, eval=TRUE, message=FALSE---------------------------
# Build a PathwaySpace for the 'g_space2'
p_space2 <- buildPathwaySpace(g_space2)

# Set '1s' as vertex signal
vertexSignal(p_space2) <- 1

## ----Polar projection - 4, eval=TRUE, message=FALSE---------------------------
# Modify the vertex 'decayFunction' attribute
vertexDecay(p_space2) <- signalDecay(shape = 2)
vertexDecay(p_space2)[["n1"]] <- signalDecay(shape = 3)

## ----Polar projection - 5, eval=FALSE, message=FALSE, out.width="70%"---------
# # Run signal projection using polar coordinates
# p_space2 <- polarProjection(p_space2, k = 2, theta = 45)
# 
# # Plot the PathwaySpace image
# plotPathwaySpace(p_space2, theme = "th2", add.marks = TRUE)

## ----Polar projection - 6, eval=FALSE, message=FALSE, out.width="70%"---------
# # Re-run signal projection using 'directional = TRUE'
# p_space2 <- polarProjection(p_space2, k = 2, theta = 45, directional = TRUE)
# 
# # Plot the PathwaySpace image
# plotPathwaySpace(p_space2, theme = "th2", marks = c("n1","n3","n4","n5"))

## ----Signal types, eval=FALSE, message=FALSE, out.width="70%"-----------------
# # Set a negative signal to vertices "n3" and "n4"
# vertexSignal(p_space1)[c("n3","n4")] <- c(-2, -4)
# 
# # Check updated signal vector
# vertexSignal(p_space1)
# # n1 n2 n3 n4 n5
# #  6  4 -2 -4  3
# 
# # Re-run signal projection
# p_space1 <- circularProjection(p_space1, k = 2,
#   decay.fun = signalDecay(shape = 2))
# 
# # Plot the PathwaySpace image
# plotPathwaySpace(p_space1, bg.color = "white", font.color = "grey20", add.marks = TRUE, mark.color = "magenta", theme = "th2")

## ----Load packages - case study, eval=FALSE, message=FALSE--------------------
# #--- Load required packages for this section
# library(PathwaySpace)
# library(RGraphSpace)
# library(igraph)
# library(ggplot2)

## ----PathwaySpace decoration - 1, eval=TRUE, message=FALSE, results='hide'----
# Load a large igraph object
data("PCv12_pruned_igraph", package = "PathwaySpace")

# Check number of vertices
length(PCv12_pruned_igraph)
# [1] 12990

# Check vertex names
head(V(PCv12_pruned_igraph)$name)
# [1] "A1BG" "AKT1" "CRISP3" "GRB2" "PIK3CA" "PIK3R1"

# Get top-connected nodes for visualization
top10hubs <- igraph::degree(PCv12_pruned_igraph)
top10hubs <- names(sort(top10hubs, decreasing = TRUE)[1:10])
head(top10hubs)
# [1] "GNB1" "TRIM28" "RPS27A" "CTNNB1" "TP53" "ACTB"

## ----PathwaySpace decoration - 2, eval=TRUE, message=FALSE--------------------
## Check graph validity
g_space_PCv12 <- GraphSpace(PCv12_pruned_igraph, mar = 0.1)

## ----PathwaySpace decoration - 3, eval=FALSE, message=FALSE-------------------
# ## Visualize the graph layout labeled with 'top10hubs' nodes
# plotGraphSpace(g_space_PCv12, node.labels = top10hubs, label.color = "blue", theme = "th3")

## ----PathwaySpace decoration - 4, eval=FALSE, message=FALSE-------------------
# # Load a list with Hallmark gene sets
# data("Hallmarks_v2023_1_Hs_symbols", package = "PathwaySpace")
# 
# # There are 50 gene sets in "hallmarks"
# length(hallmarks)
# # [1] 50
# 
# # We will use the 'HALLMARK_P53_PATHWAY' (n=200 genes) for demonstration
# length(hallmarks$HALLMARK_P53_PATHWAY)
# # [1] 200

## ----PathwaySpace decoration - 5, eval=FALSE, message=FALSE-------------------
# # Run the PathwaySpace constructor
# p_space_PCv12 <- buildPathwaySpace(gs=g_space_PCv12, nrc=500)
# # Note: 'nrc' sets the number of rows and columns of the
# # image space, which will affect the image resolution (in pixels)

## ----PathwaySpace decoration - 6, eval=FALSE, message=FALSE-------------------
# # Intersect Hallmark genes with the PathwaySpace
# hallmarks <- lapply(hallmarks, intersect, y = names(p_space_PCv12) )
# 
# # After intersection, the 'HALLMARK_P53_PATHWAY' dropped to n=173 genes
# length(hallmarks$HALLMARK_P53_PATHWAY)
# # [1] 173
# 
# # Set a binary signal (1s) to 'HALLMARK_P53_PATHWAY' genes
# vertexSignal(p_space_PCv12) <- 0
# vertexSignal(p_space_PCv12)[ hallmarks$HALLMARK_P53_PATHWAY ] <- 1

## ----PathwaySpace decoration - 7, eval=FALSE, message=FALSE-------------------
# # Run signal projection
# p_space_PCv12 <- circularProjection(p_space_PCv12)
# plotPathwaySpace(p_space_PCv12, title="HALLMARK_P53_PATHWAY", marks = top10hubs, mark.size = 2, theme = "th3")

## ----PathwaySpace decoration - 8, eval=FALSE, message=FALSE-------------------
# # Add silhouettes
# p_space_PCv12 <- silhouetteMapping(p_space_PCv12)
# plotPathwaySpace(p_space_PCv12, title="HALLMARK_P53_PATHWAY", marks = top10hubs, mark.size = 2, theme = "th3")

## ----Mapping summits - 1, eval=FALSE, message=FALSE---------------------------
# # Mapping summits
# p_space_PCv12 <- summitMapping(p_space_PCv12, minsize = 50)
# plotPathwaySpace(p_space_PCv12, title="HALLMARK_P53_PATHWAY", theme = "th3")

## ----Mapping summits - 2, eval=FALSE, message=FALSE---------------------------
# # Extracting summits from a PathwaySpace
# summits <- getPathwaySpace(p_space_PCv12, "summits")
# class(summits)
# # [1] "list"

## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()

