FROM registry.cn-shenzhen.aliyuncs.com/fyc_base/miniconda3:latest
ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"
MAINTAINER fanyucai1@126.com
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/menpo/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    conda config --set show_channel_urls yes && \
    conda install java-jdk && \
    conda install samtools=1.9 && \
    conda install bwa=0.7.17    && \
    conda install fastqc=0.11.8 && \
    conda install picard && \
    conda install GATK4 && \
    conda install varscan && \
    conda install vardict && \
    conda install delly && \
    conda install fastp && \
    conda install snpsift && \
    conda install intel-openmp && \
    conda install msisensor