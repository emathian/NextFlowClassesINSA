params.program_path = "$baseDir/TrimGalore-0.6.6/trim_galore"
params.outdir = "$baseDir/data_RNASeq_trimmed"
ch_input = Channel.fromPath("$baseDir/data/*.fastq")

process trim {

  input:
  file ori_fastq from ch_input

  script:
  """
  mkdir -p $params.outdir
  $params.program_path --illumina -q 20 -o $params.outdir ${ori_fastq} 

  """
}


params.fasta_trimmed = "$baseDir/data_RNASeq_trimmed/*.fq"
ch_fastatrim = Channel.fromPath(params.fasta_trimmed )
process fastqc {
	  publishDir "$baseDir/data_RNASeq_trimmed"
	
    input:
    file trimmed_seq from ch_fastatrim

    output:

    file("fastqc_${trimmed_seq.baseName}_logs") into fastqc_ch

    script:
    """
    mkdir \$PWD/fastqc_logs
    fastqc -o \$PWD/fastqc_logs/ -f fastq $trimmed_seq
   
    """
}
