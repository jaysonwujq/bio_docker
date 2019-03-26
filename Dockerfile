FROM registry.cn-shenzhen.aliyuncs.com/fyc_base/miniconda2:latest
ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"
MAINTAINER fanyucai1@126.com
RUN conda config --add channels https://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/ && \
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/main/ && \
    conda config --set show_channel_urls yes && \
    conda install samtools=1.9
    conda install bwa=0.7.17
    conda install fastqc=0.11.8
    conda install picard=2.19.0
    conda install GATK=4.1.0.0
    conda install varscan=2.4.3
    conda install -c bioconda/label/cf201901 vardict
    conda install -c bioconda/label/cf201901 delly
    conda install -c bioconda/label/cf201901 fastp
    conda install -c bioconda/label/cf201901 snpsift
    conda install -c bioconda/label/cf201901 msisensor