params.fastq = Channel.fromPath("$baseDir/data/*.fastq")

process generate_fastqc {
  input:
  	file x from params.fastq

  script:
  """
  fastqc ${x} --extract 
  """
}

