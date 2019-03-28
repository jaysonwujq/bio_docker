#Email:fanyucai1@126.com
#2019.1.18

import os
import argparse
import subprocess

parser=argparse.ArgumentParser("Call snp using VarDict.")
parser.add_argument("-t","--tb",help="tumor bam",required=True)
parser.add_argument("-n","--nb",help="normal bam",required=True)
parser.add_argument("-r","--ref",help="reference",required=True)
parser.add_argument("-b","--bed",help="target region bed file")
parser.add_argument("-o","--out",help="output directory",default=os.getcwd())
parser.add_argument("-pt","--ptumor",help="name of tumor",required=True)
parser.add_argument("-pt","--pnomal",help="name of normal",required=True)

args=parser.parse_args()

if not os.path.exists(args.outdir):
    os.mkdir(args.outdir)
args.tb=os.path.abspath(args.tb)
args.nb=os.path.abspath(args.nb)
par=""
if args.bed:
    args.bed=os.path.abspath(args.bed)
    par=args.bed
subprocess.check_call("VarDict -G %s -f 0.001 -N %s -b \"%s|%s\" -z -F -c 1 -S 2 -E 3 -g 4 %s|testsomatic.R|"
                      "var2vcf_paired.pl -N \"%s|%s\" -f 0.001 >%s/%s_%s.vcf"
                      %(args.ref,args.ptumor,args.tb,args.nb,par,args.tumor,args.normal,args.outdir,args.ptumor,args.pnormal),shell=True)
