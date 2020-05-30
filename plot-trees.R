# Create tree plots
# Jeffrey C. Oliver
# jcoliver@email.arizona.edu
# 2020-05-28

rm(list = ls())

################################################################################
# devtools::install_github(repo = "YuLab-SMU/ggtree")
library(ape)
library(ggplot2)
library(ggtree)
library(treeio)

tree <- treeio::read.raxml("tree_inference/Cpun_mtCo12/bs-hpc/RAxML_bipartitionsBranchLabels.Cpun_mtCo12-1000-bs")
# Replace underscores with spaces in terminal taxa names
tree@phylo$tip.label <- gsub(x = tree@phylo$tip.label,
                             pattern = "_",
                             replacement = " ")

# Will need to add colored circles corresponding to start of taxon name
# For some, groups, e.g. CG in Cpun data, there are two colors for this group...
# make plot
treeplot <- ggtree(tr = tree) +
  geom_treescale(y = -4, fontsize = 2) +
  geom_nodelab(mapping = aes(x = branch,
                             label = bootstrap,
                             vjust = -0.5),
               size = 1.25) +
  geom_tiplab(size = 1.25, offset = 0.02)

# print tree
treeplot

# Try to add group info
groups <- substr(x = tree@phylo$tip.label,
                 start = 1,
                 stop = 2)

group_info <- data.frame(taxa = tree@phylo$tip.label,
                         group = groups)
rownames(group_info) <- NULL

# CD, CG, CP, CW
treeplot <- treeplot %<+% group_info +
  geom_tippoint(mapping = aes(color = group),
                size = 1,
                position = position_nudge(x = 0.015, y = 0)) +
  scale_color_manual(values = c("#000000", "#0000FF", "#00FF00",
                                "#FF00FF", "#FF0000")) +
  theme(legend.position = "none")

# print tree
treeplot

# save tree
ggsave(filename = "tree_images/Cpun_mtCo12.pdf",
       plot = treeplot,
       height = 7, 
       units = "in")
