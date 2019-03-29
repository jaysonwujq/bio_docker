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

RUN conda install  samtools && \
    conda install  bwa    && \
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
    conda install  Pisces

RUN cd /ref/ && axel -n20 http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz && \
    tar xzvf annovar.latest.tar.gz

RUN cd /ref/annovar/humandb/ && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_cosmic70.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_cosmic70.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_clinvar_20190305.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_clinvar_20190305.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_ljb26_all.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_ljb26_all.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_exac03.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_exac03.txt && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_1000g2015aug.zip && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_avsnp150.txt.idx.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_avsnp150.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_esp6500siv2_all.txt.gz && \
    axel -n20 http://www.openbioinformatics.org/annovar/download/hg19_esp6500siv2_all.txt.idx.gz && \
    axel -n20 ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/common_all_20180423.vcf.gz && \
    axel -n20 ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/common_all_20180423.vcf.gz.tbi

RUN cd /ref/annovar/humandb/ && unzip *gz && unzip hg19_1000g2015aug.zip