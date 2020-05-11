# Convert FASTA files to phylip format
# Jeffrey C. Oliver
# jcoliver@email.arizona.edu
# 2020-04-08

rm(list = ls())

################################################################################
library(ape)

### FASTA file copy creation. Should not need to be run
# text_files <- list.files(path = "data", pattern = "*.txt", full.names = TRUE)
# # Drop the info files
# text_files <- grep(pattern = "_info.txt", x = text_files,
#                     invert = TRUE, value = TRUE)
# for (one_file in text_files) {
#   fas_file <- gsub(pattern = ".txt", replacement = ".fas", x = one_file)
#   file.copy(from = one_file, to = fas_file, overwrite = TRUE)
# }

# Read all files in data folder with the .fas extension
fasta_files <- list.files(path = "data", pattern = "*.fas", full.names = TRUE)

# Iterate over list of files, reading as a data frame and exporting as phylip
for (one_file in fasta_files){
  phy_filename <- gsub(pattern = ".fas", replacement = ".phy", x = one_file)
  df <- read.FASTA(file = one_file)
  write.dna(x = df,
            file = phy_filename,
            format = "sequential", 
            nbcol = -1, # writes sequence on single line
            colsep = "")
}
