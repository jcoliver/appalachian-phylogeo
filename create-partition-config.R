# Create configuration files for Partition Finder
# Jeffrey C. Oliver
# jcoliver@email.arizona.edu
# 2020-04-14

rm(list = ls())

################################################################################
# Get all partition data files
# Change this so each phylip file is used, then create _part_data.csv file
# only proceed if that file exists
# Why? What is added value of this?
part_files = list.files(path = "data", 
                        pattern = "*_part_data.csv",
                        full.names = TRUE)

# Iterate over part_files, read in gene and codon data
for (one_file in part_files) {
  part_filename = basename(one_file)
  part_prefix = gsub(pattern = "_part_data.csv", 
                     replacement = "", 
                     x = part_filename)
  # Read in the data
  part_data = read.csv(file = one_file, stringsAsFactors = FALSE)
  cat("\n", part_prefix, "\n")
  # Iterate over each row (gene) to write appropriate string for data block
  data_block <- "## DATA BLOCKS ##\n[data_blocks]"
  
  for (i in 1:nrow(part_data)) {
    gene_name = part_data$gene[i]
    gene_start = part_data$start[i]
    gene_end = part_data$end[i]
    codon_start = part_data$codon_start[i]
    cat(gene_name, " ", gene_start, "-", gene_end, " ", codon_start, "\n")
    # data block will differ between coding and non-coding
    if (!is.na(codon_start)) {
      # coding data, codon_start is not NA
      # ## DATA BLOCKS ##
      # [data_blocks]
      # COI_pos1 = 2-762\3;
      # COI_pos2 = 3-762\3;
      # COI_pos3 = 1-762\3;
      # COII_pos1 = 763-1125\3;
      # COII_pos2 = 764-1125\3;
      # COII_pos3 = 765-1125\3;
    } else {
      # non-coding data, codon_start is NA
      # name = start-end;
      data_block <- paste0(data_block, "\n", gene_name, " = ", gene_start, 
                           "-", gene_end, ";")
    }
  }
  cat(data_block)
}

# + Information needed (that will vary by data set)
#     1. Name of alignment file
#     2. Data blocks (locations of genes and codons)
# + Create configuration template
# + Extract the two pieces of information
# + Create a folder in partition_finder that has the config file and the phylip file

