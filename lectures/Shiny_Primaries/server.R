# server.R

library(wordcloud)
library(streamR)
source("parser.R")

tweets.df <- parseTweets("tweets.02.05.2016.json", simplify = TRUE)
tweets.df <- addCandidates(tweets.df)

shinyServer(function(input, output) {

  output$freq_plot<- renderPlot({
    candidate.df = subset(tweets.df, tweets.df$candidate == input$var)
    times <- as.POSIXct(candidate.df$created_at, format="%a %b %d %H:%M:%S %z %Y")
                          
    hist(times,
         breaks="mins")
  })
  
  output$wordcloudT <- renderPlot({
    candidate.df = subset(tweets.df, tweets.df$candidate == input$var)
    TweetCorpus <- makeCorpus(candidate.df)
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
