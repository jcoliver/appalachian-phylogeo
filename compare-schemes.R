# Compare best partition schemes from PartitionFinder runs
# Jeffrey C. Oliver
# jcoliver@email.arizona.edu
# 2020-05-14

rm(list = ls())

################################################################################

library(readr) # for reading in the best_scheme.txt data

# Use the name of the dataset (cheating and just using all the *_part_data.csv
# files)
datasets <- gsub(pattern = "_part_data.csv",
                 replacement = "",
                 x = basename(list.files(path = "data", 
                                         pattern = "*_part_data.csv",
                                         full.names = TRUE)))


models <- c("GTR", "GTR+G", "GTR+G+I")
# Iterate over each data set
# 1. Pull out AICc for each of the models
# 2. Create a table with each AICc
# 3. Order table in ascending order, identifying rate heterogeneity model with 
#    best score
# 4. Copy the analysis/best_scheme.txt file into data set directory
for (dataset in datasets) {
  cat("One dataset: ", dataset, "\n")

  model_df <- data.frame(model = models,
                         AICc = NA)
  for (model in models) {
    # remove plus signs from model, since they are not in folder names
    model_no_plus <- gsub(pattern = "\\+", 
                          replacement = "", 
                          x = model)
    
    # Path to best_scheme.txt file for this dataset/model combination
    scheme_path <- paste0("partition_finder/",
                          dataset, "/",
                          model_no_plus, "/",
                          "analysis/best_scheme.txt")
    
    # Read the entirety of the best_scheme.txt file
    scheme <- readr::read_file(file = scheme_path)

    # Extract the line with the AICc value for the scheme
    scheme_vector <- unlist(strsplit(x = scheme, split = "\n"))
    scheme_aicc <- grep(pattern = "Scheme AICc", 
                        x = scheme_vector, 
                        value = TRUE)
    
    # Just the the actual AICc value
    scheme_score <- unlist(strsplit(x = scheme_aicc,
                                    split = ":"))
    scheme_score <- trimws(x = scheme_score, which = "both")
    
    # Store scheme is appropriate row of the table
    model_df$AICc[model_df$model == model] <- scheme_score
  }
  # Sort in ascending order of AICc; smallest is best
  model_df <- model_df[order(model_df$AICc), ]
  
  model_df
  
  # Copy the best_scheme.txt file into partition_finder/<dataset> directory
  message("\nStill need to copy best_scheme.txt...")
}
