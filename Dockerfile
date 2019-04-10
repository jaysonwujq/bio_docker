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
    conda install  samtools && \
    conda install  bwa && \
    conda install  fastqc && \
    conda install  picard && \
    conda install  GATK4 && \
    conda install  varscan && \
    conda install  vardict && \
    conda install  delly && \
    conda install  fastp && \
    conda install  snpsift && \
    conda install  msisensor && \
    conda install  samblaster && \
    conda install  sambamba && \
    conda install  snpeff && \
    conda install  trimmomatic && \
    conda install  pindel && \
    conda install  seqtk && \
    conda install  parallel && \
    conda install  bedtools && \
    conda install  bamtools && \
    conda install  fgbio && \
    conda install  control-freec && \
    conda install  vcf2maf && \
    conda install  bam-readcount && \
    conda install  bcftools && \
    conda install  Pisces && \
    cd /usr/local/bin && wget https://github.com/mozack/abra2/releases/download/v2.19/abra2-2.19.jar && chmod 777 abra2-2.19.jar && \
    mkdir /ref/ && cd /ref/ && axel -n20 http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz && \
    tar xzvf annovar.latest.tar.gz && rm annovar.latest.tar.gz

RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_cosmic70.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_cosmic70.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_clinvar_20190305.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_clinvar_20190305.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_ljb26_all.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_ljb26_all.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_exac03.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_exac03.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_1000g2015aug.zip && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_avsnp150.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_avsnp150.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_esp6500siv2_all.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_esp6500siv2_all.txt.idx.gz && \
    axel -n20 ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/common_all_20180423.vcf.gz && \
    axel -n20 ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/common_all_20180423.vcf.gz.tbi && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_gnomad211_exome.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_gnomad211_exome.txt.idx.gz && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/messages && cd /ref/annovar/humandb/ && gunzip *gz && unzip hg19_1000g2015aug.zip

RUN mkdir -p /ref/genome/ && cd /ref/genome/ && \
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
    gunzip chr*.fa.gz && cd /ref/genome/ && \
    cat chr1.fa chr2.fa chr3.fa chr4.fa chr5.fa \
	chr6.fa chr7.fa chr8.fa chr9.fa chr10.fa \
	chr11.fa chr12.fa chr13.fa chr14.fa chr15.fa \
	chr16.fa chr17.fa chr18.fa chr19.fa chr20.fa \
	chr21.fa chr22.fa chrX.fa chrY.fa chrM.fa > ucsc.hg19.fasta && rm chr*fa*
RUN samtools faidx /ref/genome/ucsc.hg19.fasta && \
    bwa index /ref/genome/ucsc.hg19.fasta && \
    picard CreateSequenceDictionary R=/ref/genome/ucsc.hg19.fasta O=/ref/genome/ucsc.hg19.dict && \
ENV PATH /ref/:ref/genome/:/ref/annovar/humandb/:/ref/annovar/:$PATH

