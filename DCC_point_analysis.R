dcc <- read.table(file="C:/Libraries/Documents/DCC_Data_reorganization_final.csv",header=T, sep=",")

dcc$treat <- factor(dcc$treat)

ggplot(dcc, aes(x = treat, y = x)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID)) +
  geom_point()

dcc_unt <- subset(dcc, treat == 0)
dcc_treat <- subset(dcc, treat == 1)
dcc_treat2 <- subset(dcc, treat == 10)
dcc_treat3 <- subset(dcc, treat == 20)



#t tests
test3 <- t.test(dcc_unt$x, dcc_treat3$x, paired = TRUE)
test2 <- t.test(dcc_unt$x, dcc_treat2$x, paired = TRUE)

dcc_unt <- dcc_unt[-c(16),]

test1 <- t.test(dcc_unt$x, dcc_treat$x, paired = TRUE)

p.adjust(c(test1$p.value, test2$p.value, test3$p.value), method = "hochberg")
stats:::t.test
methods(t.test)


edit(getAnywhere('t.test'), file='source_t.test.r')
