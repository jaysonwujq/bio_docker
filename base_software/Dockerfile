FROM conda/miniconda3

ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get -qq update && apt-get -qq -y install  apt-utils axel zip unzip wget build-essential && apt-get clean

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/menpo/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    conda config --set show_channel_urls yes
RUN conda install  samtools
RUN conda install  bwa
RUN conda install  fastqc
RUN conda install  picard
RUN conda install  GATK4
RUN conda install  varscan
RUN conda install  vardict
RUN conda install  delly
RUN conda install  fastp
RUN conda install  snpsift
RUN conda install  msisensor
RUN conda install  samblaster
RUN conda install  sambamba
RUN conda install  snpeff
RUN conda install  trimmomatic
RUN conda install  pindel
RUN conda install  seqtk
RUN conda install  parallel
RUN conda install  bedtools
RUN conda install  bamtools
RUN conda install  fgbio
RUN conda install  control-freec
RUN conda install  vcf2maf
RUN conda install  bam-readcount
RUN conda install  bcftools
RUN conda install  Pisces
RUN cd /usr/local/bin && wget https://github.com/mozack/abra2/releases/download/v2.19/abra2-2.19.jar && chmod 777 abra2-2.19.jar
RUN mkdir -p /ref/
RUN cd /ref/ && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr1.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr2.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr3.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr4.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr5.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr6.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr7.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr8.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr9.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr10.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr11.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr12.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr13.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr14.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr15.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr16.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr17.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr18.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr19.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr20.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr21.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr22.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chrX.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chrY.fa.gz && \
    axel -n20 http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chrM.fa.gz && \
    gunzip chr*.fa.gz
RUN cd /ref/ && \
    cat chr1.fa chr2.fa chr3.fa chr4.fa chr5.fa \
	chr6.fa chr7.fa chr8.fa chr9.fa chr10.fa \
	chr11.fa chr12.fa chr13.fa chr14.fa chr15.fa \
	chr16.fa chr17.fa chr18.fa chr19.fa chr20.fa \
	chr21.fa chr22.fa chrX.fa chrY.fa chrM.fa > ucsc.hg19.fasta
RUN cd /ref/ && rm chr*fa*
RUN samtools faidx /ref/ucsc.hg19.fasta
RUN bwa index /ref/ucsc.hg19.fasta
RUN picard CreateSequenceDictionary R=/ref/ucsc.hg19.fasta O=/ref/ucsc.hg19.dict
ENV PATH /ref/:$PATH

