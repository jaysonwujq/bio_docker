#Email:fanyucai1@126.com
#2019.3.28

import os
import argparse
import subprocess

bwa="bwa"
samtools="samtools"
samblaster="samblaster"

parser=argparse.ArgumentParser("bwa mapping and marking duplicates.")
parser.add_argument("-p1","--pe1",help="5 reads",required=True)
parser.add_argument("-p2","--pe2",help="3 reads",required=True)
parser.add_argument("-r","--ref",help="reference",required=True)
parser.add_argument("-o","--outdir",help="output directory",default=os.getcwd())
parser.add_argument("-p","--prefix",help="prefix of output",required=True)
args=parser.parse_args()

out=args.outdir+args.prefix
cmd="%s mem -t 20 -R \'@RG\\tID:%s\\tSM:%s\\tLB:lib:\\tPL:Illumina\' %s %s %s |" %(bwa,args.prefix,args.prefix,args.ref,args.pe1,args.pe2)
cmd +="%s | %s view -Sb - > %s.bam" %(samblaster,samtools,out)
subprocess.check_calel(cmd,shell=True)


