FROM ubuntu:18.04
ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
##################################
RUN apt-get -qq update && apt-get -y install gcc libbz2-dev \
    apt-transport-https\
    git \
    liblzma-dev \
    zlib1g-dev \
    libncurses5-dev openssl \
    python \
    python-pip \
    python3 \
    python3-pip \
    apt-utils \
    axel \
    zip \
    unzip \
    wget \
    curl \
    build-essential \
    libncursesw5-dev && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -bfp /usr/local && rm -rf /tmp/miniconda.sh
ENV PATH /opt/conda/bin:$PATH
################################
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/menpo/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    conda config --set show_channel_urls yes && \
    conda install  control-freec && \
    conda install  samtools && \
    conda install  bwa && \
    conda install  fastqc && \
    conda install  picard && \
    conda install  GATK4 && \
    conda install  varscan && \
    conda install  vardict && \
    conda install  delly && \
    conda install  fastp && \
    conda install  msisensor && \
    conda install  samblaster && \
    conda install  sambamba && \
    conda install  trimmomatic && \
    conda install  pindel && \
    conda install  seqtk && \
    conda install  parallel && \
    conda install  bedtools && \
    conda install  bamtools && \
    conda install  fgbio && \
    conda install  vcf2maf && \
    conda install  bam-readcount && \
    conda install  umi_tools && \
    conda install  bcftools && \
    conda install  Pisces
#####################abra######################
RUN cd  /usr/local/bin/ && axel -n20 https://github.com/mozack/abra2/releases/download/v2.19/abra2-2.19.jar && chmod 777 /usr/local/bin/abra2-2.19.jar
####################gene fuse##################
RUN cd /usr/local/bin/ && axel -n20 http://opengene.org/GeneFuse/genefuse && chmod a+x /usr/local/bin/genefuse
####################snpeff###########################
RUN cd /usr/local/ && axel -n20 https://nchc.dl.sourceforge.net/project/snpeff/snpEff_latest_core.zip && unzip snpEff_latest_core.zip
################ R packages ################
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/'; options(repos = r);" > ~/.Rprofile
RUN axel -n20 https://cran.r-project.org/src/contrib/Archive/cghseg/cghseg_1.0.2-1.tar.gz && R CMD INSTALL cghseg_1.0.2-1.tar.gz && rm cghseg_1.0.2-1.tar.gz
RUN Rscript -e "install.packages(c('BiocManager'))"
RUN Rscript -e "BiocManager::install(c('aroma.light','DNAcopy','PSCBS'))"
RUN Rscript -e "install.packages(c('cluster','plyr','tidyverse','magrittr','data.table','cwhmisc','digest','fastICA','MASS','mclust','R.cache','gridExtra','naturalsort','scales','ggplot2','extrafont'))"
RUN mkdir ~/.Rcache
####################python2 and python3  module########################
RUN axel -n20  https://pypi.tuna.tsinghua.edu.cn/packages/6a/49/7e10686647f741bd9c8918b0decdb94135b542fe372ca1100739b8529503/xgboost-0.82-py2.py3-none-manylinux1_x86_64.whl && \
    pip2 install xgboost-0.82-py2.py3-none-manylinux1_x86_64.whl && pip3 install xgboost-0.82-py2.py3-none-manylinux1_x86_64.whl && rm xgboost-0.82-py2.py3-none-manylinux1_x86_64.whl
RUN pip2 install -i https://pypi.tuna.tsinghua.edu.cn/simple configparser biopython pysam PyVCF Cython MySQL-python pysqlite scikit-learn seaborn && \
    pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple configparser biopython pysam PyVCF Cython && \
    pip2 install -i https://pypi.tuna.tsinghua.edu.cn/simple RSeQC==2.6.6 cutadapt==1.16 tornado==5.1.1 HTSeq CNVkit json5 wheel parse2csv && \
    pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple RSeQC cutadapt tornado seaborn scikit-learn edlib HTSeq CNVkit PyYAML wheel parse2csv parse2csv
#######################set workdir##############################
RUN mkdir -p /project/
WORKDIR /project/