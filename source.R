library(KoNLP)

Sys.setenv(JAVA_HOME="C:/Program Files (x86)/Java/jre1.8.0_261/")
library(dplyr)

useNIADic()

txt <- readLines("김대중대통령연설문.txt")


library(stringr)

txt <- str_replace_all(txt, "\\W", " ")
nouns <- extractNoun(txt)

wordcount <- table(unlist(nouns))

df_word <- as.data.frame(wordcount, stringsAsFactors = F)

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

df_word <- filter(df_word, nchar(word) >= 2)
df_word <- filter(df_word, word  != '국민')
df_word <- filter(df_word, word  != '우리')

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top_20

library(wordcloud)
library(RColorBrewer)

pal <- brewer.pal(8,"Dark2")

set.seed(1234) 

wordcloud(words = df_word$word, 
          freq = df_word$freq,
          min.freq = 2, 
          max.words = 500, 
          random.order = F,
          rot.per = .1, 
          scale = c(4, 0.3), 
          colors = pal) 

