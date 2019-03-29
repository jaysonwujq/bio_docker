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


RUN mkdir /ref/
RUN cd /ref/ && axel -n20 http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz && \
    tar xzvf annovar.latest.tar.gz

RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_cosmic70.txt.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_cosmic70.txt.idx.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_clinvar_20190305.txt.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_clinvar_20190305.txt.idx.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_ljb26_all.txt.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_ljb26_all.txt.idx.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_exac03.txt.idx.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_exac03.txt.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_1000g2015aug.zip
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_avsnp150.txt.idx.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_avsnp150.txt.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_esp6500siv2_all.txt.gz
RUN cd /ref/annovar/humandb/ && axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_esp6500siv2_all.txt.idx.gz
RUN cd /ref/annovar/humandb/ && axel -n20 ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/common_all_20180423.vcf.gz
RUN cd /ref/annovar/humandb/ && axel -n20 ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/common_all_20180423.vcf.gz.tbi
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/messages
RUN cd /ref/annovar/humandb/ && gunzip *gz && unzip hg19_1000g2015aug.zip

RUN mkdir /ref/hg19/
RUN cd /ref/hg19/ && axel -n20 https://storage.googleapis.com/qiaseq-dna/data/genome/ucsc.hg19.dict
RUN cd /ref/hg19/ && axel -n20 https://storage.googleapis.com/qiaseq-dna/data/genome/ucsc.hg19.fa.gz
RUN cd /ref/hg19/ && gunzip ucsc.hg19.fa.gz
RUN samtools faidx /ref/hg19/ucsc.hg19.fa
RUN bwa index /ref/hg19/ucsc.hg19.fa

