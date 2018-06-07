require(ggplot2)

dcc <- read.table(file="D:/Caroline/DCC_new_data_analysis_2.csv",header=T, sep=",")



dcc$time_taken <- factor(dcc$time_taken)


#plot out various interesting stats
ggplot(dcc, aes(x = time_taken, y = number_of_DCC_clusters)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + guides(color = FALSE)

#plot out various interesting stats
ggplot(dcc, aes(x = time_taken, y = cluster_are_perc)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + guides(color = FALSE)


#plot out various interesting stats
ggplot(dcc, aes(x = time_taken, y = deltaF)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + guides(color = FALSE)

#plot out various interesting stats
ggplot(dcc, aes(x = time_taken, y = integrated_int)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + guides(color = FALSE)







dcc_unt <- subset(dcc, time_taken == 0)
dcc_treat <- subset(dcc, time_taken == 1)
dcc_treat2 <- subset(dcc, time_taken == 10)
dcc_treat3 <- subset(dcc, time_taken == 20)



#t tests
t.test(dcc_unt$integrated_int, dcc_treat3$integrated_int, paired = TRUE)




test3 <- t.test(dcc_unt$x, dcc_treat3$x, paired = TRUE)
test2 <- t.test(dcc_unt$x, dcc_treat2$x, paired = TRUE)

dcc_unt <- dcc_unt[-c(16),]

test1 <- t.test(dcc_unt$x, dcc_treat$x, paired = TRUE)

p.adjust(c(test1$p.value, test2$p.value, test3$p.value), method = "hochberg")
stats:::t.test
methods(t.test)


edit(getAnywhere('t.test'), file='source_t.test.r')
