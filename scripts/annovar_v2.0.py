#Email:fanyucai1@126.com
#2019.3.26-2019.

import os
import subprocess
import argparse
import re

annovar="/ref/annovar/annovar/"
common_dbsnp="/data/Database/hg19/dbsnp/dbsnp.common.vcf"
snpsift="SnpSift.jar"
java="java"
database = ['1000g2015aug_all', 'ExAC_ALL', 'esp6500siv2_all', 'ExAC_AFR', 'ExAC_AMR', 'ExAC_EAS', 'ExAC_FIN',
            'ExAC_NFE','ExAC_OTH', 'ExAC_SAS']
"""
####################
Cheng D T, Mitchell T N, Zehir A, et al. Memorial Sloan Kettering-Integrated Mutation Profiling of Actionable Cancer Targets (MSK-IMPACT): a hybridization capture-based next-generation sequencing clinical assay for solid tumor molecular oncology[J]. The Journal of molecular diagnostics, 2015, 17(3): 251-264.
Analysis of Tumor Mutational Burden with TruSight® Tumor 170
####################
"""
parser=argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
                               description="Run annovar and filter vcf as followed:\n"
                                           "1:Depth>=50\n"
                                           "2:hotspot point (presented with >=5 mentions in COSMIC and MAF<0.4 in population database) will retain\n"
                                           "3:dicard synonymous SNV,intronic,intergenic\n"
                                           "4:dicard common snp from:dbsnp,1000Genomes,EXAC,ESP\n")
parser.add_argument("-v","--vcf",help="vcf file",type=str,required=True)
parser.add_argument("-m","--maf",type=int,help="default:0.01",default=0.01)
parser.add_argument("-c","--counts",type=int,default=5,help="hotspot point presented with >=5 mentions in COSMIC")
parser.add_argument("-cm","--cosmic_maf",type=float,default=0.4,help="filter hotspot point mutations if MAF>=0.4 in population database")
parser.add_argument("-d","--depth",help="Total read depth default:50",default=50,type=int)
parser.add_argument("-o","--outdir",help="output directoty",default=os.getcwd())
parser.add_argument("-p","--prefix",help="prefix of output",default="annovar")
result=parser.parse_args()

if not os.path.exists(result.outdir):
    os.mkdir(result.outdir)
result.outdir = os.path.abspath(result.outdir)
result.vcf=os.path.abspath(result.vcf)
os.chdir(result.outdir)
out=result.outdir
out+="/"
out+=result.prefix
##########################use snpsift filter depth
cmd="cat %s|%s -jar %s filter \" ( DP >= %s )\" > %s/filtered_depth.vcf" %(result.vcf,java,snpsift,result.depth,out)
subprocess.check_call(cmd,shell=True)
#########################run annovar
par=" -protocol refGene,cytoBand,avsnp150,exac03,esp6500siv2_all,1000g2015aug_all,cosmic70,clinvar_20190305,ljb26_all "
par+=" -operation g,r,f,f,f,f,f,f,f "
par+=" -nastring . -polish "
subprocess.check_call("cd %s && perl %s/table_annovar.pl %s/filtered_depth.vcf %s/humandb -buildver hg19 -out %s -remove %s -vcfinput "
                      %(result.outdir,annovar,out,annovar,result.prefix,par),shell=True)
subprocess.check_call("rm -rf %s.hg19_multianno.vcf %s.avinput" %(out,out),shell=True)
infile=open("%s.hg19_multianno.txt" %(out),"r")
outfile=open("%s.annovar.filter.txt" %(out),"w")
##############################convert common snp into dict
def read_common(vcf,dict):
    infile2=open(vcf,"r")
    for line in infile2:
        if not line.startswith("#"):
            line=line.strip()
            array=line.split()
            string=array[0]+"_"+array[1]+"_"+array[3]+"_"+array[4]
            dict[string]=1
common={}
read_common(common_dbsnp,common)
##############################
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
                for i in database:
                    if array[dict[i]] != "." and float(array[dict[i]]) >= result.cosmic_maf:
                        line="0"
                if line !="0":
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
            for i in database:
                if array[dict[i]] != "." and float(array[dict[i]])>result.maf:
                    line="0"
                    continue
            if line !="0" :
                outfile.write("%s\n" % (line))
infile.close()
outfile.close()
