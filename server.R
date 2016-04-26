# server.R

library(streamR)
library(tm)
library(wordcloud)
#source("parse.R")
setwd("~/Documents/dailytweets_wordcloud")

#used static data as opposed to streaming!
#load("my_oauth.Rdata")
#load("all_candidates.json")

#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)

#creates a wordcloud from input dataframe

toCorpus <- function(dframe) {
  text <- sapply(dframe$text, function(row) iconv(row, "latin1", "ASCII", sub = ""))
  #removes all http from text
  text <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", text)
  TweetCorpus <- paste(unlist(text), collapse =" ") 
  TweetCorpus <- Corpus(VectorSource(TweetCorpus))
  TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
  TweetCorpus <- tm_map(TweetCorpus, removePunctuation)
  TweetCorpus <- tm_map(TweetCorpus, removeWords, stopwords('english'))
  # TweetCorpus <- tm_map(TweetCorpus, stemDocument)
  TweetCorpus <- tm_map(TweetCorpus, content_transformer(tolower),lazy=TRUE)
  TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
  #want to remove candidates from their own wordcloud
  TweetCorpus <- tm_map(TweetCorpus, removeWords, c("like","will", "president", "say", "realjameswood", "for", "think", "the", "dont", "new", "amp", "get", "now","via", "this", "presid", "end", "while", "doesnt", "httpstcoau9loazlxp",  "httpstcoatbyuvqbkp", "https", "chrischristi", "that", "httpstco", "httpst", "http", "car", "chris", "christi", "hillaryclinton","johnkasich", "marcorubio", "hillari", "carlyfiorina", "fiorina", "hillary",  "berniesand", "sander", "berni", "realdonaldtrump", "bernie", "sanders", "donald", "trump", "clinton", 
                                                    "hillary clinton", "bernie sanders", "jeb bush", "marco rubio", "ted cruz", "donald trump", "john kasich", "ben carson", "chris christie", "carly fiorina", "hillaryclinton", 
                                                    "jebbush", "berniesanders", "marcorubio", "chrischristie", "bencarson", "johnkasich", "donaldtrump", "tedcruz", "carlyfiorina"
  ))
  return(TweetCorpus)
}

#creates wordcloud for each candidate
BernieCorpus <- toCorpus(BernieTotals)
HillaryCorpus <- toCorpus(HillaryTotals)
TedCorpus <- toCorpus(TedTotals)
MarcoCorpus <- toCorpus(MarcoTotals)
DonaldCorpus <- toCorpus(DonaldTotals)


#logic behind the UI of the R application

shinyServer(function(input, output) {
  
  output$wordcloudT <- renderPlot({
    if (input$var == "Hillary Clinton"){
      HillaryTotals<- HillaryTotals[grep(input$date, HillaryTotals$created_at), ]
      HillaryCorpus <- toCorpus(HillaryTotals)
      corpus <- HillaryCorpus
    } else if (input$var == 'Bernie Sanders'){
      BernieTotals<- BernieTotals[grep(input$date, BernieTotals$created_at), ]
      BernieCorpus <- toCorpus(BernieTotals)
      corpus <- BernieCorpus
      
    } else if (input$var == 'Ted Cruz'){
      TedTotals<- TedTotals[grep(input$date, TedTotals$created_at), ]
      TedCorpus <- toCorpus(TedTotals)
      corpus <- TedCorpus
    }
    else if  (input$var == 'Donald Trump'){
      DonaldTotals<- DonaldTotals[grep(input$date, DonaldTotals$created_at), ]
     
      DonaldCorpus <- toCorpus(DonaldTotals)
      corpus <-DonaldCorpus
    }
    else if  (input$var == 'Marco Rubio'){
      MarcoTotals<- MarcoTotals[grep(input$date, MarcoTotals$created_at), ]
      MarcoCorpus <- toCorpus(MarcoTotals)
      corpus <-MarcoCorpus
     
     
    }
    wordcloud(corpus, max.words = input$wordCount, random.order = FALSE,scale=c(3.75,.05), min.freq=2, colors=brewer.pal(8, "Blues"))
  })
  
  
  output$freq_plot<- renderPlot({
    
    
    if (input$var == "Hillary Clinton"){
      filename <- HillaryTotals
      filename  <- HillaryTotals[grep(input$date, HillaryTotals$created_at), ]
    } else if (input$var == 'Bernie Sanders'){
      filename <- BernieTotals
      filename <- BernieTotals[grep(input$date, BernieTotals$created_at), ]
    } else if (input$var == 'Ted Cruz'){
      filename <- TedTotals
      filename <- TedTotals<- TedTotals[grep(input$date, TedTotals$created_at), ]
    }
    else if  (input$var == 'Donald Trump'){
      filename <-DonaldTotals
      filename <- DonaldTotals[grep(input$date, DonaldTotals$created_at), ]
    }
    else if  (input$var == 'Marco Rubio'){
      filename <-MarcoTotals
      filename <- MarcoTotals[grep(input$date, MarcoTotals$created_at), ]
     
    }
    
    
    #displays histogram associated with input filename
    times <- as.POSIXct(filename$created_at, format="%a %b %d %H:%M:%S %z %Y")
    hist(times, breaks=35)
    
  })
  
  
  
  #shows users where their cursor is currently
  output$info_click <- renderText({
    paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  })
  
  
  #lets users know which candidate they have selected and who's data they are looking at
  output$text1 <- renderText({ 
    paste("You have selected ", input$var)
  })
  
  
}
)
