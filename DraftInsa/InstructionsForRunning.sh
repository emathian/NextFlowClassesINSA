#Medical Genomics TP1: 
## Set up conda env with dependencies
### if never used
export PATH=$PATH:/opt/anaconda3/bin
conda init bash
### In any case
conda create -n TP1
conda activate TP1
conda install -c bioconda nextflow
conda install -c conda-forge singularity
conda install -c bioconda salmon
#singularity config global -s "mksquashfs path" "/opt/anaconda3/envs/TP1/bin/unsquashfs" if necessary
​
## Try a simple nextflow pipeline
### clone test data
git clone https://github.com/IARCbioinfo/data_test
## Question 2
## run RNA-seq pipeline
nextflow run iarcbioinfo/RNAseq-nf -r v2.2 -profile conda \
    --input_folder data_test/FASTQ/ --ref_folder data_test/REF/ \
    --gtf data_test/REF/ctat_genome_lib_build_dir_TP53/ref_annot.gtf \
    --fastq_ext fastq.gz --bed data_test/BED/TP53_small.bed --mem 5 --cpu 2
​
nextflow run iarcbioinfo/RNAseq-nf -r v2.2 -profile singularity \
    --input_folder data_test/FASTQ/ --ref_folder data_test/REF/ \
    --gtf data_test/REF/ctat_genome_lib_build_dir_TP53/ref_annot.gtf \
    --fastq_ext fastq.gz --bed data_test/BED/TP53_small.bed --mem 5 --cpu 2

## Question 3: 
# See: hello.nf
nextflow run HelloWorld.nf
nextflow run HelloWorld.nf --greeting "Hola el mundo!"