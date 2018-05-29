#This analysis pulls in the giant DCC clustering dataset and 

require(ggplot2)

dcc <- read.table(file="D:/Caroline/DCC_Data_reorganization_final.csv",header=T, sep=",")


#Turn the treatment amount into a factor
dcc$Dose <- factor(dcc$Treatment)



#just plot WT data
dcc_wt <- subset(dcc,Genotype == "wt" & Dose == "500" & Netrin_type == "f")
dcc_67 <- subset(dcc,Genotype == "t67" & Dose == "500" & Netrin_type == "Soluble")

dcc_wt <- subset(dcc,Genotype == "wt" & Dose == "500")

#post just the wt dcc cluster count
ggplot(dcc_wt, aes(x = Prepost, y = number_of_DCC_clusters)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + scale_x_discrete(limits = rev(levels(dcc_wt$Prepost))) +
  guides(color = FALSE)

#post the deltaF of each cluster
ggplot(dcc_wt, aes(x = Prepost, y = deltaF)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + scale_x_discrete(limits = rev(levels(dcc_wt$Prepost)))

#post the deltaF of each cluster
ggplot(dcc, aes(x = Dose, y = number_of_DCC_clusters)) +
  geom_boxplot(outlier.shape = NA) +
  geom_line(aes(group = ID_pair, color = ID_pair)) +
  geom_point() + guides(color=FALSE)



#t 
dcc_unt_wt <- subset(dcc_wt, Dose == 500 & Prepost == 'pre')
dcc_500_wt <- subset(dcc_wt, Dose == 500 & Prepost == 'post')


wat1 <- log(dcc_unt_wt$number_of_DCC_clusters)
wat2 <- log(dcc_500_wt$number_of_DCC_clusters)
boxplot(wat1,wat2)
t.test(wat1,wat2,paired = TRUE)


t.test(dcc_unt_wt$number_of_DCC_clusters, dcc_500_wt$number_of_DCC_clusters, paired = TRUE)
