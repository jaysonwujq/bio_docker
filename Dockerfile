FROM registry.cn-shenzhen.aliyuncs.com/fyc_base/tumor_base_1.0:latest
ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"
MAINTAINER fanyucai1@126.com
RUN mkdir /project
COPY scripts/* /project/
WORKDIR /project/
ENV PATH /project/:/usr/local/bin/:$PATH
CMD ["python3","fastp.py"]