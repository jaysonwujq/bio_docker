# Base镜像说明
    该镜像基于miniconda3构建用于肿瘤panel分析的常见分析软件，包含的软件以及版本为：
    samtools=1.9 bwa=0.7.17 fastqc=0.11.8 picard=2.18.27 GATK4=4.1.0.0 fastp=0.19.7
    varscan=2.4.3 msisensor=0.5 vardict=2018.10.18 delly=0.8.1 snpsift=4.3.1t
    samblaster-0.1.24 sambamba-0.6.8 snpeff-4.3.1t parallel-20190122 trimmomatic-0.38 pindel-0.2.5b9 seqtk-1.3
    bedtools-2.27.1 bamtools-2.5.1 fgbio-0.8.0 vcf2maf bam-readcount-0.8 bcftools-1.9 pisces-5.2.9.122
    
    用户下载使用可以直接使用：
    FROM registry.cn-shenzhen.aliyuncs.com/fyc_base/tumor_base:latest
 
    
