library(bootnet); library(qgraph)

data(big5)              # load the practice dataset
Data <- big5[, 1:20]    # use just the first 20 items so the plot is readable

# step 1: building the network
Network <- estimateNetwork(Data, default = "EBICglasso")

png("/Users/ericawu/Downloads/education/research/node-network/network.png", width = 1000, height = 1000)
plot(Network, layout = "spring", labels = TRUE)
dev.off()

# step 2: centrality
print(centralityPlot(Network, include = "ExpectedInfluence"))

# step 3: how accurate are the edges
boot1 <- bootnet(Network, nBoots = 10, nCores = 8)
print(plot(boot1, labels = FALSE, order = "sample"))

# step 4: are the centrality rankings stable
boot2 <- bootnet(Network, nBOots = 100, type = "case", nCores = 8, statistics = c("strength", "expectedInfluence"))
print(plot(boot2))
corStability(boot2)

# step 5: comparing centrality between nodes
print(differenceTest(boot1, 3, 17, "strength"))
print(plot(boot1, "strength"))