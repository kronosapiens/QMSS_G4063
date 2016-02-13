# server.R

library(wordcloud)
library(streamR)
source("parser.R")

tweets.df <- parseTweets("tweets.json", simplify = TRUE)
tweets.df$created_at <- as.POSIXct(tweets.df$created_at, format="%a %b %d %H:%M:%S %z %Y")
tweets.df <- addCandidates(tweets.df)

shinyServer(function(input, output) {
  
  output$freq_plot <- renderPlot({
    candidate.df <- subset(tweets.df, tweets.df$candidate == input$var)
    hist(candidate.df$created_at,
         main='Tweet frequency',
         breaks="hours")
  })
  
  output$wordcloudT <- renderPlot({
    candidate.df <- subset(tweets.df, tweets.df$candidate == input$var)
    TweetCorpus <- makeCorpus(candidate.df)
    wordcloud(TweetCorpus,
              max.words = 20,
              min.freq = 3,
              random.order=FALSE,
              scale=c(8,1),
              colors=brewer.pal(8, "Dark2"))
    })
  
  output$info_click <- renderText({
    paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  })

  
}
)
