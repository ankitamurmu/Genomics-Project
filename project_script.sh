#!/bin/bash

#downloading the complete sample list
wget https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/Global_genome_structure_project/complete_1000_genomes_sample_list_.tsv

#downloading the chromosome 1 variants genotyping file
wget http://hgdownload.cse.ucsc.edu/gbdb/hg19/1000Genomes/phase3/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz

#downloading the population sample file/sample population mapping file
wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel

#download vcf_to_ped_convert.pl file
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/browser/vcf_to_ped_converter/version_1.1/vcf_to_ped_convert.pl
chmod 755 vcf_to_ped_convert.pl

#convert vcf to ped
perl vcf_to_ped_convert.pl -vcf ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz  -sample_panel_file integrated_call_samples_v3.20130502.ALL.panel -region 1:1-150000 -population GBR -population FIN -population CHS -population KHV -population BEB -population PUR -population ACB -population ASW -population YRI -population GWD -population JPT -population MSL -population CEU -population ESN -population CHB -population CLM -population CDX -population PEL -population PJL -population IBS -population TSI -population MXL -population LWK -population GIH -population STU -population ITU -base_format letter

#Convert the info file to map using info_to_map.pl
perl info_to_map.pl 1_1-150000.info > 1_1-150000.map

#downloading and installing plink-https://knowledgebase.aridhia.io/article/installing-plink-on-your-virtual-machine/
wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20220402.zip
unzip plink_linux_x86_64_20220402.zip

#To make PLINK accessible from the command line anywhere in the file system, we need to copy the PLINK executable to the usr/local/bin directory, and make it executable:
sudo cp plink /usr/local/bin
sudo chmod 755 /usr/local/bin/plink

#Next, you need to add PLINK to PATH. To do this, run:
sudo nano ~/.bashrc

#This will open the nano editor in the terminal. Scroll down to the bottom of the file and add the following line:
export PATH=/usr/local/bin:$PATH

#save and exit the file.

#to test run
plink

#Using plink to generate the binary versions of ped and map files
plink --file 1_1-150000 --make-bed --out 1_1-150000

#generating eigen values
plink --bed 1_1-150000.bed --bim 1_1-150000.bim --fam 1_1-150000.fam --pca

#run the R script for PCA
Rscript pca_plot.r

