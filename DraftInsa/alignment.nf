
ref_genome_ch   = Channel.fromPath( "$baseDir/data_test/REF/ctat_genome_lib_build_dir_TP53/ref_genome.fa" )
process IndexRef {
    publishDir 'INDEX', mode: 'copy'
    input:
    path genome_ref from ref_genome_ch
   
    output:
    file 'index' into index_ch

    script:
    """
    salmon index -t $genome_ref -i index -k 31 
    """
}
params.reads = "$baseDir/data_test/FASTQ/*_{1,2}.fastq.gz"
reads_pairs_ch = Channel.fromFilePairs(params.reads)
params.index = "$baseDir/INDEX/index"

process Mapping {
    cpus 2
    publishDir 'Alignments'

    input:
    file indexref from params.index
    tuple pair_id, path(reads) from reads_pairs_ch
 
    output:
    path pair_id into quant_ch
 
    script:
    """
    salmon quant --threads $task.cpus --libType=A -i $params.index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id 
    """
}

    
