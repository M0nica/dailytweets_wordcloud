#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
setwd("~/Documents/dailytweets_wordcloud")

#tweets_shiny1.df <- parseTweets("tweets.02.01.2016.summary.json", simplify = TRUE)


tweets_shiny2.df <- parseTweets("sm.tweets.02.09.2016.summary.json", simplify = TRUE)
tweets_shiny3.df <- parseTweets("sm.tweets.02.20.2016.summary.json", simplify = TRUE)
tweets_shiny4.df <- parseTweets("sm.tweets.02.23.2016.summary.json", simplify = TRUE)
tweets_shiny5.df <- parseTweets("sm.tweets.02.27.2016.summary.json", simplify = TRUE)
tweets_shiny6.df <- parseTweets("sm.tweets.03.01.2016.summary.json", simplify = TRUE)
tweets_shiny7.df <- parseTweets("sm.tweets.03.05.2016.summary.json", simplify = TRUE)
tweets_shiny8.df <- parseTweets("sm.tweets.03.08.2016.summary.json", simplify = TRUE)
tweets_shiny9.df <- parseTweets("sm.tweets.03.12.2016.summary.json", simplify = TRUE)
tweets_shiny10.df <- parseTweets("sm.tweets.03.15.2016.summary.json", simplify = TRUE)
tweets_shiny11.df <- parseTweets("sm.tweets.03.22.2016.summary.json", simplify = TRUE)
tweets_shiny12.df <- parseTweets("sm.tweets.03.26.2016.summary.json", simplify = TRUE)
tweets_shiny13.df <- parseTweets("sm.tweets.04.05.2016.summary.json", simplify = TRUE)
tweets_shiny14.df <- parseTweets("sm.tweets.04.09.2016.summary.json", simplify = TRUE)
tweets_shiny15.df <- parseTweets("sm.tweets.04.19.2016.summary.json", simplify = TRUE)




tweets_shiny.df<- rbind(tweets_shiny2.df, tweets_shiny3.df, tweets_shiny4.df, tweets_shiny5.df, tweets_shiny6.df, tweets_shiny7.df,tweets_shiny8.df,tweets_shiny9.df,tweets_shiny10.df,tweets_shiny11.df,tweets_shiny12.df,tweets_shiny13.df,tweets_shiny14.df)


#get rid of emojis
tweets_shiny.df$text <- sapply(tweets_shiny.df$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
#make tweets go to lowercase 
HillaryClinton <- tweets_shiny.df[grep("Hillary Clinton", tweets_shiny.df$text), ]
HillaryClinton_wo <- tweets_shiny.df[grep("HillaryClinton", tweets_shiny.df$text), ]
HillaryTotals <- rbind(HillaryClinton, HillaryClinton_wo)
HillaryTotals219<- HillaryTotals[grep("Feb 09", HillaryTotals$created_at), ]
HillaryTotals409<- HillaryTotals[grep("Apr 09", HillaryTotals$created_at), ]
write.csv(HillaryTotals, file = "HillaryClintonTotalsTest.csv")
#load(HillaryTotals)

#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
BernieSanders<- tweets_shiny.df[grep("Bernie Sanders", tweets_shiny.df$text), ]
BernieSanders_wo <- tweets_shiny.df[grep("BernieSanders", tweets_shiny.df$text), ]
BernieTotals <- rbind(BernieSanders, BernieSanders_wo)

#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
DonaldTrump<- tweets_shiny.df[grep("Donald Trump", tweets_shiny.df$text), ]
DonaldTrump_wo <- tweets_shiny.df[grep("DonaldTrump", tweets_shiny.df$text), ]
DonaldTotals <- rbind(DonaldTrump, DonaldTrump_wo)


#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
TedCruz<- tweets_shiny.df[grep("Ted Cruz", tweets_shiny.df$text), ]
TedCruz_wo <- tweets_shiny.df[grep("TedCruz", tweets_shiny.df$text), ]
TedTotals <- rbind(TedCruz, TedCruz_wo)


#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
MarcoRubio<- tweets_shiny.df[grep("Marco Rubio", tweets_shiny.df$text), ]
MarcoRubio_wo <- tweets_shiny.df[grep("MarcoRubio", tweets_shiny.df$text), ]
MarcoTotals <- rbind(MarcoRubio, MarcoRubio_wo)
#load(MarcoTotals)
