# Create configuration files for Partition Finder
# Jeffrey C. Oliver
# jcoliver@email.arizona.edu
# 2020-04-14

rm(list = ls())

################################################################################
# Get all partition data files
part_files = list.files(path = "data", 
                        pattern = "*_part_data.csv",
                        full.names = TRUE)

# Iterate over part_files, read in gene and codon data
for (one_file in part_files) {
  part_filename = basename(one_file)
  part_prefix = gsub(pattern = "_part_data.csv", 
                     replacement = "", 
                     x = part_filename)
  part_path = paste0(dirname(one_file), "/", part_prefix)
  
  alignment_block = paste0("## ALIGNMENT FILE #\nalignment = ", part_prefix, ".phy")

  cat(alignment_block, "\n")
  
  # Read in the data
  part_data = read.csv(file = one_file, stringsAsFactors = FALSE)
  # cat("\n\n", part_prefix, "\n")
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
        data_block = paste0(data_block, "\n", codon)
      }
    } else {
      # non-coding data, codon_start is NA
      data_block <- paste0(data_block, "\n", gene_name, " = ", gene_start, 
                           "-", gene_end, ";")
    }
  }
  config_filename = paste0(part_path, "/partition_finder.cfg")
  if (!dir.exists(part_path)) {
    # dir.create(part_path)
    cat("\n\nWill create ", part_path, "\n")
  }
  
  # Will write to 
  cat("Will write to ", config_filename, "\n")
  cat(data_block)
}

# + Information needed (that will vary by data set)
#     1. Name of alignment file
#     2. Data blocks (locations of genes and codons)
# + Create configuration template
# + Extract the two pieces of information
# + Create a folder in partition_finder that has the config file and the phylip file

