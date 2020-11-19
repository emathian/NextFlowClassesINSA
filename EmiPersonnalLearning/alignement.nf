#!/usr/bin/env nextflow

ref_genome_ch   = Channel.fromPath( "$baseDir/GRCh38_gencode_v33_CTAT_lib_Apr062020.source/GRCh38.primary_assembly.genome.fa" )
process IndexqtionREf {
	publishDir '/data_index'
    input:
    file genome_ref from ref_genome_ch
   
    output:
    file  "*.{amb,ann,bwt,pac,sa}" into index_ref_ch


    script:
    """
    bwa index -a bwtsw  $genome_ref
    """
}



transcriptome_trimmed_ch = Channel.fromPath( "$baseDir/data_RNASeq_trimmed/SRR7646230_trimmed.fq" )
/*
process IndexqtionTrqnscriptome {
	publishDir '/data_index'
    input:
    file transcriptome_trimmed from transcriptome_trimmed_ch
    output:
    file "*.{amb,ann,bwt,pac,sa}" into index_transicriptome_ch


    script:
    """
    bwa index -a bwtsw $transcriptome_trimmed
    """
}
*/


process Map {
	publishDir '/data_alignment'

	input:
    file indexref from index_ref_ch
    file trimmed_transcriptome from transcriptome_trimmed_ch

 
    output:
    file "*.{sam,bam}" into alignment_ch
 
    script:
    """
    bwa mem -M $indexref $transcriptome_trimmed_ch 
    """
}

