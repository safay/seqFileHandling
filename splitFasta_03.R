#!/usr/bin/env Rscript 

# load required Bioconductor library, Biostrings
library(Biostrings)

# set user-defined variables here
filepath <- '~/yourDirectory/someBigSetOfSeqs.fasta'       # where is the file you want to split?
outFilePrefix <- '~/yourDirectory/splitDir/someBigSetOfSeqs_split_'  # the prefix for the output files
seqsPerFile <- 500                                  # how many sequences do you want in each file?

# load some data, initialize more variables
seqs <- readDNAStringSet(filepath)               # Make a DNAStringSet object
numSeqs <- length(seqs)                 # numSeqs is total number of sequences
i <- 1                            # i is an index for counting sequences
j <- 1                            # j is an index for counting files

# loop for building the individual files
while (i < numSeqs) {
  if ((i+seqsPerFile) > numSeqs) {
    cat('writing last file with seqs ', i, '-', numSeqs, '\n')
    outFile <- paste(outFilePrefix, '_', sprintf('%03d', j), '.fasta', sep='')  # change the "%03d" here to change the number of digits to pad; currently 3 digits
    writeXStringSet(seqs[i:numSeqs], outFile)
  } else {
    cat('writing a file with seqs', i, '-', (i+seqsPerFile-1), '\n')
    outFile <- paste(outFilePrefix, '_', sprintf('%03d', j), '.fasta', sep='')  # change the "%03d" here to change the number of digits to pad; currently 3 digits
    writeXStringSet(seqs[i:(i+seqsPerFile-1)], outFile)
  }
  i <- i+seqsPerFile
  j <- j+1
}

# remove all objects from memory
rm(list = ls())

# This code snippet pads the filename number with zeros:
# sprintf('%03d', j)
