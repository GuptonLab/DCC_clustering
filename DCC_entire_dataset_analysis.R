require(ggplot2)

dcc <- read.table(file="D:/Caroline/DCC_Data_reorganization_final.csv",header=T, sep=",")


#get rid of the weird extra columns
dcc$Dose <- factor(dcc$Treatment)



#just plot WT data
dcc_wt <- subset(dcc,Genotype == "wt" & Dose == "1000" & Netrin_type == "Soluble")
dcc_67 <- subset(dcc,Genotype == "t67" & Dose == "1000" & Netrin_type == "Soluble")

#post just the wt dcc cluster count
ggplot(dcc_67, aes(x = Prepost, y = number_of_DCC_clusters)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + scale_x_discrete(limits = rev(levels(dcc_wt$Prepost)))

#post the deltaF of each cluster
ggplot(dcc_67, aes(x = Prepost, y = deltaF)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + scale_x_discrete(limits = rev(levels(dcc_wt$Prepost)))


#t test em all
dcc_unt_wt <- subset(dcc_wt, Dose == 500 & Prepost == 'pre')
dcc_500_wt <- subset(dcc_wt, Dose == 500 & Prepost == 'post')


wat1 <- log(dcc_unt_wt$counts)
wat2 <- log(dcc_500_wt$counts)
boxplot(wat1,wat2)
t.test(wat1,wat2,paired = TRUE)
dcc_unt_wt <- subset(dcc_wt, Dose == 500 & Treatment == 'n' & Netrin_type == 'F')
dcc_500_wt <- subset(dcc_wt, Dose == 500 & Treatment == 'y' & Netrin_type == 'F')
t.test(dcc_unt_wt$counts, dcc_500_wt$counts, paired = TRUE)

boxplot(dcc_500_wt$counts, dcc_unt_wt$counts)


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

