FROM registry.cn-shenzhen.aliyuncs.com/fyc_base/miniconda2:latest
MAINTAINER fanyucai1@126.com
RUN conda config --add channels https://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/ && \
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/main/ && \
    conda config --set show_channel_urls yes && \
    conda install bowtie=1.2.2
