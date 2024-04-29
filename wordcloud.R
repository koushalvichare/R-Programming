###NLP

install.packages("tm")
install.packages(("SnowballC"))
install.packages("wordcloud")
library(tm)

library("SnowballC")
library("wordcloud")
library("RColorBrewer")
txt<-read.csv(file.choose(),header=TRUE)
dim(txt)
corp<-iconv(txt$sentence)
corp<-Corpus(VectorSource(corp))
inspect(corp[1:5])

#start processing
corp<-tm_map(corp,content_transformer(tolower))
inspect(corp[1:5])
corp<-tm_map(corp,removeNumbers)
corp<-tm_map(corp,removeWords,stopwords("english"))
corp<-tm_map(corp,removePunctuation)
corp<-tm_map(corp,stripWhitespace)
corp<-tm_map(corp,stemDocument)
inspect(corp[1:5])
corp<-tm_map(corp,removeWords,c("get","told","took","gave","can"))
corp<-TermDocumentMatrix(corp)
corp
corp<-as.matrix(corp)
corp
srt<-sort(rowSums(corp))
srt
df_wordcloud<-data.frame(word=names(srt),freq=srt)
View(df_wordcloud)
wordcloud(df_wordcloud$word,df_wordcloud$freq,random.order = FALSE,rot.per = 0.4,scale = c(4,.5),min.freq=1,max.words=200,
          colors = brewer.pal(5,"Dark2"))

