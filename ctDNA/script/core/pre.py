import os
import sys
import subprocess

java="java"
picard="/software/picard/picard.jar"
bwa="/software/bwa/bwa-0.7.17/bwa"
ref="/data/Database/hg19/ucsc.hg19.fasta"
samtools="/software/samtools/samtools-v1.9/bin/samtools"

def run(pe1,pe2,outdir,prefix):
    if os.path.exists(outdir):
        os.mkdir(outdir)
    out=outdir+"/"+prefix
    cmd = "%s mem -t 10 -R \'@RG\\tID:%s\\tSM:%s\\tLB:lib:\\tPL:Illumina\' %s %s %s |" % (bwa, prefix, prefix, ref, pe1, pe2)
    cmd += "%s view -@ 10 -o %s.bam" % (samtools, out)
    subprocess.check_call(cmd, shell=True)
    cmd = "%s sort -@ 10 %s.bam -o %s.sort.bam" % (samtools, out, out)
    subprocess.check_call(cmd, shell=True)
    cmd = "%s index %s.sort.bam" % (samtools, out)
    subprocess.check_call(cmd, shell=True)
    cmd = "%s -Xmx100G -jar %s MarkDuplicates I=%s.sort.bam O=%s.dup.bam M=%s.marked_dup_metrics.txt" % (java, picard, out, out, out)
    subprocess.check_call(cmd, shell=True)

if __name__=="__main__":
    if len(sys.argv)!=5:
        print("usage:python3 %s sample.R1.fastq sample.R2.fastq outdir prefix\n"%(sys.argv[0]))
        print("#Email:fanyucai1@126.com")
    else:
        pe1=sys.argv[1]
        pe2=sys.argv[2]
        outdir=sys.argv[3]
        prefix=sys.argv[4]
        run(pe1, pe2, outdir, prefix)