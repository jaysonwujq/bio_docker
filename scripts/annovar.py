#Email:fanyucai1@126.com
#2019.1.15-2019.3.26

import os
import subprocess
import argparse
import re

annovar="/ref/annovar/annovar/"
common_dbsnp="/data/Database/hg19/dbsnp/dbsnp.common.vcf"
"""
####################
Variants listed in COSMIC version 64 were considered hotspot point mutations if they presented with >=5 mentions
ref:
Cheng D T, Mitchell T N, Zehir A, et al. Memorial Sloan Kettering-Integrated Mutation Profiling of Actionable Cancer Targets (MSK-IMPACT): a hybridization capture-based next-generation sequencing clinical assay for solid tumor molecular oncology[J]. The Journal of molecular diagnostics, 2015, 17(3): 251-264.
Analysis of Tumor Mutational Burden with TruSight® Tumor 170
#####################
filter common in dbsnp:
common SNP is one that has at least one 1000Genomes population with a MAF >= 1% and for which 2 or more founders contribute to that minor allele frequency.
ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/
#####################
filter:synonymous SNV,intronic,intergenic
filter(MAF>0.01):1000g2015aug_all','ExAC_ALL','esp6500siv2_all','ExAC_AFR','ExAC_AMR','ExAC_EAS','ExAC_FIN','ExAC_NFE','ExAC_OTH','ExAC_SAS
####################
"""
parser=argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
                               description="This script will annotate vcf and filter MAF<0.01 basing frequency of variants database.")
parser.add_argument("-v","--vcf",help="vcf file",type=str,required=True)
parser.add_argument("-m","--maf",type=int,help="minor allele frequency default:0.01",default=0.01)
parser.add_argument("-c","--counts",type=int,default=5,help="mininum number observed in COSMIC default will retain:4")
parser.add_argument("-o","--outdir",help="output directoty",default=os.getcwd())
parser.add_argument("-p","--prefix",help="prefix of output",default="annovar")
result=parser.parse_args()

if not os.path.exists(result.outdir):
    os.mkdir(result.outdir)
result.outdir=os.path.abspath(result.outdir)
result.vcf=os.path.abspath(result.vcf)
os.chdir(result.outdir)
out=result.outdir
out+="/"
out+=result.prefix
par=" -protocol refGene,cytoBand,avsnp150,exac03,esp6500siv2_all,1000g2015aug_all,cosmic70,clinvar_20190305,ljb26_all "
par+=" -operation g,r,f,f,f,f,f,f,f "
par+=" -nastring . -polish "
subprocess.check_call("cd %s && perl %s/table_annovar.pl %s %s/humandb -buildver hg19 -out %s -remove %s -vcfinput "
                      %(result.outdir,annovar,result.vcf,annovar,result.prefix,par),shell=True)
subprocess.check_call("rm -rf %s.hg19_multianno.vcf %s.avinput" %(out,out),shell=True)
infile=open("%s.hg19_multianno.txt" %(out),"r")
outfile=open("%s.annovar.filter.txt" %(out),"w")
infile2=open(common_dbsnp,"r")
common={}
for line in infile2:
    if not line.startswith("#"):
        line=line.strip()
        array=line.split()
        string=array[0]+"_"+array[1]+"_"+array[3]+"_"+array[4]
        common[string]=1
num=-1
dict={}
for line in infile:
    line=line.strip()
    array=line.split("\t")
    num+=1
    if num == 0:
        outfile.write("%s\n" % (line))
        for i in range(len(array)):
            dict[array[i]] = i
    else:
        string = array[0] + "_" + array[1] + "_" + array[3] + "_" + array[4]
        if array[dict['cosmic70']].startswith("ID="):
            pattern = re.compile(r'(\d+)\(')
            a = pattern.findall(array[dict['cosmic70']])
            sum = 0
            for i in a:
                sum += int(i)
            if sum >= result.counts:
                outfile.write("%s\n" % (line))
                continue
            else:
                pass
        elif array[8]=="synonymous SNV":
            continue
        elif array[5]=="intronic":
            continue
        elif array[5]=="intergenic":
            continue
        elif string in common:
            continue
        else:
            database=['1000g2015aug_all','ExAC_ALL','esp6500siv2_all','ExAC_AFR','ExAC_AMR','ExAC_EAS','ExAC_FIN','ExAC_NFE',
                   'ExAC_OTH','ExAC_SAS']
            for i in database:
                if array[dict[i]] != "." and float(array[dict[i]])>result.maf:
                    line="0"
                    continue
            if line !="0" :
                outfile.write("%s\n" % (line))
infile.close()
outfile.close()
