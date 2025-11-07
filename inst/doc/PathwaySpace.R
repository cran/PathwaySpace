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
# p_space1 <- circularProjection(p_space1, k = 1,
#   decay.fun = weibullDecay(pdist = 0.4))
# 
# # Plot a PathwaySpace image
# plotPathwaySpace(p_space1, add.marks = TRUE)

## ----Circular projection - 3, eval=FALSE, message=FALSE, out.width="70%"------
# # Re-run signal projection, adjusting Weibull's shape
# p_space1 <- circularProjection(p_space1, k = 2,
#   decay.fun = weibullDecay(shape = 2, pdist = 0.2))
# 
# # Plot PathwaySpace
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
# Modify decay function
# ..for all vertices
vertexDecay(p_space2) <- weibullDecay(shape=2, pdist = 1)
# ..for individual vertices
vertexDecay(p_space2)[["n6"]] <- weibullDecay(shape=3, pdist = 1)

## ----Polar projection - 5, eval=FALSE, message=FALSE, out.width="70%"---------
# # Run signal projection using polar coordinates
# p_space2 <- polarProjection(p_space2, beta = 10)
# 
# # Plot PathwaySpace
# plotPathwaySpace(p_space2, theme = "th2", add.marks = TRUE)

## ----Polar projection - 6, eval=FALSE, message=FALSE, out.width="70%"---------
# # Re-run signal projection using 'directional = TRUE'
# p_space2 <- polarProjection(p_space2, beta = 10, directional = TRUE)
# 
# # Plot PathwaySpace
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
# p_space1 <- circularProjection(p_space1, decay.fun = weibullDecay(shape = 2))
# 
# # Plot PathwaySpace
# plotPathwaySpace(p_space1, bg.color = "white", font.color = "grey20", add.marks = TRUE, mark.color = "magenta", theme = "th2")

## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()

