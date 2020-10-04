#!/usr/bin/env nextflow

sra_ch   = Channel.fromPath( "$baseDir/data/*.sra" )

process SRAToFastq {

    input:
    file sample from sra_ch

    script:
    """
    fastq-dump $sample
    """
}

