# server.R

library(wordcloud)
library(streamR)
source("parser.R")

tweets.df <- parseTweets("tweets_BS.json", simplify = TRUE)

shinyServer(function(input, output) {

  #candidate.df = subset(tweets.df, tweets.df$candidate == input.var)
  candidate.df = tweets.df
  TweetCorpus <- makeCorpus(candidate.df)
  times <- as.POSIXct(candidate.df$created_at, format="%a %b %d %H:%M:%S %z %Y")
  
  
  output$freq_plot<- renderPlot({
    hist(times,
         breaks="mins")
  })
  
  output$wordcloudT <- renderPlot({
    wordcloud(TweetCorpus,
              max.words = 100,
              random.order=FALSE,
              scale=c(8,1),
              colors=brewer.pal(8, "Dark2"))
    })
  
  output$info_click <- renderText({
    paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  })

  
}
)
