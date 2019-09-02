FROM centos:latest
RUN mkdir /software/ && yum install -y wget rpm
RUN rpm -aq|grep yum|xargs rpm -e --nodeps
RUN cd /software/ && wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-3.4.3-161.el7.centos.noarch.rpm && wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-metadata-parser-1.1.4-10.el7.x86_64.rpm && wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-50.el7.noarch.rpm
RUN cd /software/ && rpm -ivh yum-3.4.3-161.el7.centos.noarch.rpm yum-metadata-parser-1.1.4-10.el7.x86_64.rpm yum-plugin-fastestmirror-1.1.31-50.el7.noarch.rpm && rm /etc/yum.repos.d/* && rm *.rpm
COPY CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum clean all &&  yum makecache && rpm --rebuilddb && yum install -y gdb strace gcc-c++ autoconf wget epel-release java tar gcc openssl-devel bzip2-devel libffi-devel python-pip axel mysql-devel libcurl Cython python-devel sqlite-devel swig libffi-devel audit libxslt-devel libxml2-devel ncurses-devel
RUN yum install -y R python-pip && mkdir ~/.Rcache && mkdir /software/python3

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/'; options(repos = r);" > ~/.Rprofile
RUN wget https://cran.r-project.org/src/contrib/Archive/cghseg/cghseg_1.0.2-1.tar.gz && R CMD INSTALL cghseg_1.0.2-1.tar.gz && rm cghseg_1.0.2-1.tar.gz
RUN Rscript -e "install.packages(\"BiocManager\")" && Rscript -e "options(BioC_mirror=\"http://mirrors.ustc.edu.cn/bioc/\")" && Rscript -e "BiocManager::install(c('ggplot2'))"

##python3
COPY Python-3.7.0.tgz /software/python3/
RUN cd /software/python3/ && tar xvf Python-3.7.0.tgz && cd Python-3.7.0 &&  ./configure --prefix=/software/python3/Python-v3.7.0 --enable-optimizations && make -j20 && make install && rm ../Python-3.7.0.tgz
RUN pip2 install --upgrade pip && pip2 install --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/ pandas==0.23.2 numpy==1.14.4 scipy==1.2.0 matplotlib==2.2.2 seaborn==0.8 pysam==0.15.1 configparser biopython PyVCF MySQL-python pysqlite scikit-learn==0.20.0 RSeQC==2.6.6 cutadapt==1.16 tornado==5.1.1 HTSeq CNVkit json5 wheel parse2csv networkx==2.2
RUN /software/python3/Python-v3.7.0/bin/pip3 install --upgrade pip && /software/python3/Python-v3.7.0/bin/pip3 install --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/ pandas==0.24.2 numpy configparser biopython pysam matplotlib
RUN /software/python3/Python-v3.7.0/bin/pip3 install --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/ Cython==0.27.3
RUN /software/python3/Python-v3.7.0/bin/pip3 install --trusted-host mirrors.aliyun.com -i http://mirrors.aliyun.com/pypi/simple/ PyVCF RSeQC cutadapt tornado seaborn scikit-learn edlib CNVkit PyYAML wheel parse2csv

RUN rm -rf /software/python3/Python-3.7.0 && mkdir /data/ && mkdir /data/Database/ && mkdir /project/ && mkdir /software/Delly && mkdir /software/abra2/  && mkdir /software/genefuse/ && mkdir /software/samtools/ && mkdir /software/bwa/ && \
    mkdir /software/Trimmomatic/ && mkdir /software/picard && mkdir /software/fgbio/ && mkdir /software/vardict/ && mkdir /software/GATK/
COPY abra2-2.20.jar /software/abra2/
COPY bwa-0.7.17.tar /software/bwa/
COPY delly_v0.8.1_linux_x86_64bit /software/Delly/
COPY fastp.dms  /software/fastp/fastp
COPY genefuse.dms /software/genefuse/genefuse
COPY picard.jar /software/picard/
COPY fgbio-1.0.0.jar /software/fgbio/
COPY samtools-1.9.tar /software/samtools/
COPY Trimmomatic-0.39.zip /software/Trimmomatic/
COPY VarDict-1.6.0.tar /software/vardict/
COPY gatk-4.1.3.0.zip /software/GATK/
RUN chmod 755 /software/genefuse/genefuse /software/fastp/fastp /software/Delly/delly_v0.8.1_linux_x86_64bit
RUN cd /software/samtools/ && tar xvf samtools-1.9.tar && cd samtools-1.9 && ./configure --prefix=/software/samtools/samtools-v1.9 && make -j20 && make install && rm -rf /software/samtools/samtools-1.9.tar /software/samtools/samtools-1.9
RUN cd /software/bwa/ && tar xvf bwa-0.7.17.tar && cd bwa-0.7.17 && rm /software/bwa/bwa-0.7.17.tar && make && cd /software/GATK/ && unzip gatk-4.1.3.0.zip && rm gatk-4.1.3.0.zip && cd /software/Trimmomatic/ && unzip Trimmomatic-0.39.zip && rm Trimmomatic-0.39.zip && cd /software/vardict/ && tar xvf VarDict-1.6.0.tar && rm VarDict-1.6.0.tar
#######################set workdir##############################
WORKDIR /project/