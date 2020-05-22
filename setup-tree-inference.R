# Set up tree inference files
# Jeffrey C. Oliver
# jcoliver@email.arizona.edu
# 2020-05-22

rm(list = ls())

################################################################################
# Create folders within the tree_inference folder; one for each data set
# Copy the .phy file for each data set for each folder

phy_files <- list.files(path = "data",
                        pattern = "*.phy",
                        full.names = TRUE)

for (one_phy in phy_files) {
  # Pull out the dataset name from the phylip file, will be used for paths  
  dataset_name <- gsub(x = basename(one_phy),
                       pattern = ".phy",
                       replacement = "")
  
  # The path the data will be copied to in the tree_inference folder
  dest_path <- paste0("tree_inference/", dataset_name)
  
  # Make sure the directory exists
  if (!dir.exists(dest_path)) {
    dir.create(dest_path)
    message(paste0("Created directory ", dest_path))
  }

  # Copy the file to appropriate folder in tree_inference directory  
  file.copy(from = one_phy, 
            to = paste0(dest_path, "/", basename(one_phy)),
            overwrite = TRUE)
}

