reads_ch = Channel.fromPath("$baseDir/data/*.sra" )

process foo {
  input:
     file(sample_files) from reads_ch
  output:
    file "${sample_files.baseName}.fastqc"  into fast_qc
  script:
  """
    echo your_command_here --reads $sample_files > "${sample_files.baseName}.fastqc" 
  """
}

fast_qc.view()