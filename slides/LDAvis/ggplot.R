library(ggplot2)
terms <- c("statistics", "moments", "good", "dull", "laugh", "please")
A <- c(0.28, 0.22, 0.15, 0.13, 0.12, 0.1)
B <- c(0.08, 0.1, 0.23, 0.15, 0.33, 0.11)
C <- c(0.1, 0.11, 0.13, 0.29, 0.12, 0.25)
df <- reshape2::melt(data.frame(A, B, C, terms), id.vars = "terms", variable.name = "Topic")
p <- ggplot(data = df, aes(x = terms, y = value, fill = Topic)) + 
  geom_bar(stat = "identity", position = "dodge") + coord_flip() + xlab("") + 
  ggtitle("Probability of word given topic") + theme(axis.text=element_text(size=20))
ggsave("ggplot.png", p, height = 4, width = 5)
