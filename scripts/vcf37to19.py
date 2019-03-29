#Email:fanyucai1@126.com
#2019.3.29

import argparse
import os
import subprocess
GATK4="gatk"
parser=argparse.ArgumentParser("liftover GRch37 to hg19")
parser.add_argument("-v","--vcf",help="vcf file",required=True)
parser.add_argument("-p","--prefix",required=True,help="prefix of output")
parser.add_argument("-r","--ref",required=True,help="hg19 fasta sequence")
parser.add_argument("-o","--outdir",required=True,default=os.getcwd(),help="output directory")
args=parser.parse_args()
out=args.outdir+args.prefix
cmd="%s --java-options \"-Djava.io.tmpdir=./ -Xmx60G\" LiftoverVcf -I %s -O %s.hg19.vcf.gz -R %s --REJECT %s/unmapped.vcf -C b37tohg19.chain" \
    %(GATK4,args.vcf,out,args.ref,args.outdir)
subprocess.check_call(cmd,shell=True)