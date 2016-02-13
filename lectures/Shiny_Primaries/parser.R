# parser.R

library(tm)

candidates <- c("Hillary Clinton", "Bernie Sanders",
                "Ted Cruz", "Marco Rubio","Donald Trump")

makeCorpus <- function(dframe) {
  dframe$text <- sapply(dframe$text, function(row) iconv(row, "latin1", "ASCII", sub="")) # UTF8?
  
  TweetCorpus <- paste(unlist(dframe$text), collapse =" ") # Collapse all text to single array
  TweetCorpus <- Corpus(VectorSource(TweetCorpus)) # Convert to VCorpus datatype
  
  # Apply a series of text mining operations to prepare the data
  TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
  TweetCorpus <- tm_map(TweetCorpus, removePunctuation)
  TweetCorpus <- tm_map(TweetCorpus, removeWords, stopwords('english'))
  #TweetCorpus <- tm_map(TweetCorpus, stemDocument)
  sTweetCorpus <- tm_map(TweetCorpus, content_transformer(tolower), lazy=TRUE)
  TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
  return(TweetCorpus)
}

addCandidates <- function(dframe) {
  dframe$candidates = "NA"
  for (candidate in candidates) {
    dframe$candidates[grepl(candidate, dframe$tex)] = candidate
  }
  return(dframe)
}