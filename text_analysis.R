library(tm)

# importing text file

data <- readLines("jubo.txt")

# transforming file to corpus

corpus <- Corpus(VectorSource(data))

# cheacking a random corpus

inspect(corpus[8])

# cleaning the data

# changing all the word to lower case

corpus <- tm_map(corpus, tolower)

# remove all the punctuation

corpus <- tm_map(corpus, removePunctuation)

# remove all the numbers

corpus <- tm_map(corpus, removeNumbers)

# removing common english word

corpus <- tm_map(corpus, removeWords, stopwords("english"))

# removing the spaces created by the previous function

corpus <- tm_map(corpus, stripWhitespace)

# model

dtm <- TermDocumentMatrix(corpus)

findFreqTerms(dtm, lowfreq = 2)

# visulisation

library(ggplot2)
library(wordcloud)

# creating barchart of most frequently words 

termFrrequency <- rowSums(as.matrix(dtm))
termFrrequency <- subset(termFrrequency, termFrrequency >=5)
barplot(termFrrequency, las = 2, col = rainbow(20))

# creating a wordCloud

m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words= 200, random.order=FALSE, scale=c(1,.5), rot.per= 0.3, 
          colors=brewer.pal(8, "Dark2"))


