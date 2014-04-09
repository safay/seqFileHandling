#!/usr/bin/env Rscript 

# load required Bioconductor library, Biostrings
library(Biostrings)

#####
#
# User-set parameters
#
#####

# choose the fasta input file
fastaFileIn <- file.choose()

# choose the .csv of transcript IDs to build the new fasta file from
selectedSeqIDs <- file.choose()

# set the output filename
outFastaName <- "nanostring_target_sequences.fa"


#####
#
# Main body
#
#####

# set the working directory to that with the transcripts file
setwd(dirname(selectedSeqIDs))

# load in the sequences
seqs <- readDNAStringSet(fastaFileIn)

# load in the transcript list
transcriptsList <- read.csv(selectedSeqIDs)
colnames(transcriptsList) <- "ID"

# fix the transcript names: remove the inchworm contig range info
# make a list of the full names of the transcripts
fullNames <- names(seqs)
# function to get just the first part of a given sequence ID
getShortID <- function(x) {
  unlist(strsplit(x, split=" "))[1]
} 
# apply this function to shorten all of the names
shortNames <- lapply(fullNames, getShortID)
# now actually change the names of the transcripts seqs object
names(seqs) <- shortNames

# now filter the seq object with our list of desired transcript IDs
targetSeqs <- seqs[names(seqs) %in% transcriptsList$ID]
targetSeqs

# write a file
writeXStringSet(targetSeqs, outFastaName)

