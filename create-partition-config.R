# Create configuration files for Partition Finder
# Jeffrey C. Oliver
# jcoliver@email.arizona.edu
# 2020-04-14

rm(list = ls())

################################################################################
# Creates configuration files for PartitionFinder2 (partition_finder.cfg) for 
# each data set. Includes codon information (for coding genes). Because we will 
# ultimately use RAxML for analyses, will need to explicitly run separate 
# PartitionFinder2 analyses for each of three rate heterogeneity models (GTR, 
# GTR+G, and GTR+G+I)

library(readr) # for reading in the "other" blocks

# Get all partition data files; these have gene and, where applicable, codon 
# information
part_files <- list.files(path = "data", 
                        pattern = "*_part_data.csv",
                        full.names = TRUE)

# Grab the "other blocks" i.e. template files which have all but the alignment 
# block and the data block
branch_model_blocks <- readr::read_file(file = "data/config_template_branch_models.txt")
schemes_block <- readr::read_file(file = "data/config_template_schemes.txt")

# Strings to indicate model to test in "models = " statement in configuration 
# file; GTR+I+G is odd, but that's the way PartitionFinder wants it
models <- c("GTR", "GTR+G", "GTR+I+G")

# Iterate over part_files, read in gene and codon data
for (one_file in part_files) {
  # Will use the base name of the file for folder names
  part_filename <- basename(one_file)
  part_prefix <- gsub(pattern = "_part_data.csv", 
                     replacement = "", 
                     x = part_filename)
  part_path <- paste0("partition_finder/", part_prefix)

  # Make sure the dataset folder exists
  if (!dir.exists(part_path)) {
    dir.create(part_path)
    message(paste0("\n\nCreated directory ", part_path))
  }

  alignment_filename = paste0(part_prefix, ".phy")
  alignment_block = paste0("## ALIGNMENT FILE #\nalignment = ", 
                           alignment_filename,
                           ";")

  # Read in the data
  part_data = read.csv(file = one_file, stringsAsFactors = FALSE)

  # Iterate over each row (gene) to write appropriate string for data block
  data_block <- "## DATA BLOCKS ##\n[data_blocks]"
  
  for (i in 1:nrow(part_data)) {
    gene_name = part_data$gene[i]
    gene_start = part_data$start[i]
    gene_end = part_data$end[i]
    codon_start = part_data$codon_start[i]
    # data block will differ between coding and non-coding
    if (!is.na(codon_start)) {
      # coding data, codon_start is not NA
      # COII_pos1 = 763-1125\3;
      # COII_pos2 = 764-1125\3;
      # COII_pos3 = 765-1125\3;

      codons = paste0(gene_name, paste0("_pos", 1:3))

      pos_starts <- c(0, 1, 2)
      if (codon_start == 2) {
        pos_starts <- pos_starts[c(2, 3, 1)]
      } else if (codon_start == 3) {
        pos_starts <- pos_starts[c(3, 1, 2)]
      }

      codons = paste0(codons, " = ", (gene_start + pos_starts), "-", gene_end, "\\3;")
      for (codon in codons) {
        cat("Add codon: ", codon, "\n")
        data_block = paste0(data_block, "\n", codon)
      }
    } else {
      # non-coding data, codon_start is NA
      data_block <- paste0(data_block, "\n", gene_name, " = ", gene_start, 
                           "-", gene_end, ";")
    }
  }

  # Will need to run a separate analysis for each of three possible RAxML
  # rate heterogeneity models (GTR, GTR+G, and GTR+G+I)
  for (model in models) {
    # Will create a separate folder for each of three rate heterogeneity models,
    # but for paths, we will remove the plus-sign
    model_path <- paste0(part_path, "/", gsub(pattern = "\\+", 
                                              replacement = "", 
                                              x = model))

    # Update the "models = INSERTMODELHERE" statement with the actual model to 
    # test
    one_model_blocks <- gsub(pattern = "INSERTMODELHERE",
                                replacement = model,
                                x = branch_model_blocks)
    
    # Make sure a directory for the configuration file exists
    if (!dir.exists(model_path)) {
      dir.create(model_path)
      message(paste0("\n\nCreated directory ", model_path))
    }
    
    # Write the alignment block, other blocks, and data block to the 
    # configuration file
    config_filename = paste0(model_path, "/partition_finder.cfg")
    
    sink(file = config_filename)
    cat(alignment_block, "\n\n")
    cat(one_model_blocks, "\n")
    # Need to insert the data block between the models and schemes blocks
    cat(data_block, "\n\n")
    cat(schemes_block)
    sink()
    message(paste0("\nWrote configuration file to ", config_filename))
    
    # And copy the alignment file to the same directory
    file.copy(from = paste0("data/", alignment_filename),
              to = paste0(model_path, "/", alignment_filename),
              overwrite = TRUE)
    message(paste0("Copied alignment file ", alignment_filename, " to ", model_path))
  }
}
