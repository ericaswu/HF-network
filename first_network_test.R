# install.packages(c("bootnet", "qgraph"), repos = "https://cloud.r-project.org")

library(bootnet); library(qgraph)

data(big5)              # load the practice dataset
Data <- big5[, 1:20]    # use just the first 20 items so the plot is readable

Network <- estimateNetwork(Data, default = "EBICglasso")

png("/Users/ericawu/Downloads/education/research/node-network/network.png", width = 1000, height = 1000)
plot(Network, layout = "spring", labels = TRUE)
dev.off()

centralityPlot(Network, include = "ExpectedInfluence")
boot1 <- bootnet(Network, nBoots = 1000, nCores = 8)

plot(boot1, labels = FALSE, order = "sample")
