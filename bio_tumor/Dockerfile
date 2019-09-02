FROM fanyucai1/base:1.0

RUN mkdir /software/Delly && mkdir /software/abra2/  && mkdir /software/genefuse/ && mkdir /software/samtools/ && mkdir /software/bwa/ && \
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
RUN rpm --rebuilddb && yum install -y ncurses-devel && cd /software/samtools/ && tar xvf samtools-1.9.tar && cd samtools-1.9 && ./configure --prefix=/software/samtools/samtools-v1.9 && make -j20 && make install && rm -rf /software/samtools/samtools-1.9.tar /software/samtools/samtools-1.9
RUN cd /software/bwa/ && tar xvf bwa-0.7.17.tar && cd bwa-0.7.17 && rm /software/bwa/bwa-0.7.17.tar && make && cd /software/GATK/ && unzip gatk-4.1.3.0.zip && rm gatk-4.1.3.0.zip && cd /software/Trimmomatic/ && unzip Trimmomatic-0.39.zip && rm Trimmomatic-0.39.zip && cd /software/vardict/ && tar xvf VarDict-1.6.0.tar && rm VarDict-1.6.0.tar
#######################set workdir##############################

RUN mkdir -p /project/
WORKDIR /project/