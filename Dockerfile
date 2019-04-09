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
    conda config --set show_channel_urls yes && \
    conda installsamtools && \
    conda installbwa && \
    conda installfastqc && \
    conda installpicard && \
    conda installGATK4 && \
    conda installvarscan && \
    conda installvardict && \
    conda installdelly && \
    conda installfastp && \
    conda installsnpsift && \
    conda installmsisensor && \
    conda installsamblaster && \
    conda installsambamba && \
    conda installsnpeff && \
    conda installtrimmomatic && \
    conda installpindel && \
    conda installseqtk && \
    conda installparallel && \
    conda installbedtools && \
    conda installbamtools && \
    conda installfgbio && \
    conda installcontrol-freec && \
    conda installvcf2maf && \
    conda installbam-readcount && \
    conda installbcftools && \
    conda installPisces && \
    cd /usr/local/bin && wget https://github.com/mozack/abra2/releases/download/v2.19/abra2-2.19.jar && chmod 777 abra2-2.19.jar
RUN mkdir -p /ref/ && cd /ref/ && \
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
    gunzip chr*.fa.gz && \
    cat chr1.fa chr2.fa chr3.fa chr4.fa chr5.fa \
	chr6.fa chr7.fa chr8.fa chr9.fa chr10.fa \
	chr11.fa chr12.fa chr13.fa chr14.fa chr15.fa \
	chr16.fa chr17.fa chr18.fa chr19.fa chr20.fa \
	chr21.fa chr22.fa chrX.fa chrY.fa chrM.fa > ucsc.hg19.fasta && rm chr*fa*
RUN samtools faidx /ref/ucsc.hg19.fasta && bwa index /ref/ucsc.hg19.fasta && picard CreateSequenceDictionary R=/ref/ucsc.hg19.fasta O=/ref/ucsc.hg19.dict
ENV PATH /ref/:$PATH

