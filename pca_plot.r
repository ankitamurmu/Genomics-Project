#setting directory
setwd("D:/HackBio/Stage 3")
#checking if the directory is set
getwd()

#loading ggplot2
library("ggplot2")


#saving the information from the file to an input file
#The file name needs to be enclosed within double quotes, the sep command specifies how columns are defined, and header=F, means that the first line of the file is not column names. 

#read the complete 1000 genomes sample list data
metadata <- read.table("D:/HackBio/Stage 3/sample_list_1000 genomes_grch38.tsv", sep = "\t", header = TRUE)

#display metadata
head(metadata)

#pca1
#read the eigenvec file
pca1 <- read.table("D:/HackBio/Stage 3/plink.eigenvec", sep =" ", header = F)

#merge data from pca1 and metadata
#Because we have no headers in this file, R arbitrarily gives these are V number, so the first two columns are called V1 and V2. 
merge_data1 <- merge(x= pca1,y = metadata,by.x = "V2", by.y = "Sample.name", all = F )


#plot with ggplot
ggplot(data = merge_data1, aes(V3,V4,color = Superpopulation.code)) + geom_point(size = 2.5)+
  scale_color_brewer(palette = "Set1") + theme_classic() + labs (title = "PCA Plot 1")+
  xlab("PC1") + ylab("PC2")+
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size =30),
        axis.title.x = element_text(face = "italic", color="blue", size = 14),
        axis.title.y = element_text(face = "italic", color="#993333", size = 14))


#save the pca plot 1
ggsave("plot1.png", width = 25, height = 20, units = "cm", limitsize = FALSE, path = "D:/HackBio/Stage 3", dpi = 300)



#pca2
#read the eigenvec file
pca2 <- read.table("D:/HackBio/Stage 3/plink.eigenvec", sep =" ", header = F)

#merge data from pca2 and metadata
merge_data2 <- merge(x= pca2,y = metadata,by.x = "V2", by.y = "Sample.name", all = F )

#plot with ggplot
ggplot(data=merge_data2, aes(V4,V5,color = Superpopulation.code)) + geom_point(size = 2.5)+
  scale_color_brewer(palette = "Dark2") + theme_classic()+ labs (title = "PCA Plot 2")+
  xlab("PC2") + ylab("PC3")+
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size =30),
        axis.title.x = element_text(face = "italic", color="green", size = 14),
        axis.title.y = element_text(face = "italic", color="blue", size = 14))


#save the pca plot 2
ggsave("plot2.png", width = 25, height = 20, units = "cm", limitsize = FALSE, path = "D:/HackBio/Stage 3", dpi = 300)


#pca3
#read the eigenvec file for pca3
pca3 <- read.table("D:/HackBio/Stage 3/plink.eigenvec", sep =" ", header = F)

#merge data from pca3 and metadata
merge_data3 <- merge(x= pca3,y = metadata,by.x = "V2", by.y = "Sample.name", all = F )

#plot with ggplot
ggplot(data=merge_data3, aes(V19,V20,color = Superpopulation.code)) + geom_point(size = 2.5)+
  scale_color_brewer(palette = "Paired") + theme_classic()+ labs (title = "PCA Plot 3")+
  xlab("PC19") + ylab("PC20")+
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size =30),
        axis.title.x = element_text(face = "italic", color="red", size = 14),
        axis.title.y = element_text(face = "italic", color="blue", size = 14))

#save the pca plot 3
ggsave("plot3.png", width = 25, height = 20, units = "cm", limitsize = FALSE, path = "D:/HackBio/Stage 3", dpi = 300)

