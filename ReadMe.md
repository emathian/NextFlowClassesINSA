# Practical 1: Developing and deploying an open-source medical genomic bioinformatic workflow

- use the Nextflow DSL to run parallel, scalable analyses on High Performance Computing and cloud computing facilities
- efficient use of github for open-source development and Continuous Integration automated tests
- reliance on conda and docker/singularity containers for reproducibility

## Prerequisites
**Case 1 You are on an INSA machine:**
<ol>
<li> Create a conda environment eg.
 
 `conda create -n nf_tp1`

<li> Install Nextflow through the following command: 
        
`conda install -c bioconda nextflow`

<li> Install Singularity such as:

`conda install -c conda-forge singularity`
<li> Install the speudo aligner Salmon:

`conda install -c bioconda salmon`

Check if the package is correctly installed running: `salmon --version` in a terminal the expected output is `version : 0.8.1`, if not try `conda install -c bioconda/label/cf201901 salmon`.
</ol>


**Case 2 You are working locally on your own Linux machine (or on a Linux VM):**
<ol>
<li> Check your version of java:

`java version`

If you don't have java or if you have a version lower than 8 please run the following command: `sudo apt-get install openjdk-8-jre`

<li> If you have anaconda or (miniconda) continue the setup process following the instructions given for the first case.
    Otherwise install miniconda:
    <ol>
    <li>Download miniconda:

`wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh`
    <li> Install miniconda eg. 
`bash /home/username/miniconda.sh`
    <li> Export the path eg. `export PATH=$PATH:/miniconda3/bin` (or edit the .bashrc file)
    <li> Init conda: `conda init`
    <li> Restart a new terminal and continue the setup process with the instructions given for the first case.
    </ol>
</ol>

**Case 3 Any of these solutions work:**
Follow the official instructions:
- [Nextflow installed](https://www.nextflow.io/docs/latest/getstarted.html)

**In ANY case:**
Have a look at the [NextFlow tutorial](https://seqera.io/training/). 

*What is [singularity](https://sylabs.io/guides/3.6/user-guide/)?* *Maybe to delete if we use conda.*

## How to use the available ressources?

**Question 1:** Create a working directory and clone inside the github repository https://github.com/IARCbioinfo/data_test.git. A data test set is particulary useful to develop bioinformatics tools. Can you explain why? 

**Question 2:** Browse the repository https://github.com/IARCbioinfo/RNAseq-nf and run the pipeline.

**Hints:** 

- Nextflow allow executing of a pipeline directly from a GitHub repository.
- To run a pipeline you need to call the right computational environment.
- What are the mandatory parameters?
- What are the optional parameters that can be useful?

**Expected outputs:**

`[4b/a37d19] process > fastqc_pretrim (NA06984_T_RG1) [100%] 3 of 3 ✔
[4a/5fe731] process > alignment (NA06984_T_RG1)      [100%] 3 of 3 ✔
[63/12a97e] process > RSEQC (NA06984_T_RG1)          [100%] 3 of 3 ✔
[-        ] process > RSEQCsplit                     -
[a4/1afaec] process > quantification (NA06984_T_RG1) [100%] 3 of 3 ✔
[52/de307e] process > multiqc_pretrim (all)          [100%] 1 of 1 ✔
[97/96c127] process > multiqc_posttrim (all)         [100%] 1 of 1 ✔
Completed at: 19-Nov-2020 09:08:47
Duration    : 15m 13s
CPU hours   : 0.1
Succeeded   : 14`

**Question 3:** While the pipeline is running ...

Try to create your first nexflow script. Call it "HelloWorld.nf". This sctipt should contain:
- A parameter named greeting equivalent to "Hello world!";
- A queue channel built from the previous parameter;
- A process that includes:
    + A directive allowing to print the outputs returned by the command "echo";
    + An input declaration block built from the queue channel;
    + An output declaration block that creates a channel from the outputs of the "echo" command;
    + A bash process that should "echo" the input channel's value.

Run this script with the command line: `nextflow run HelloWorld.nf`. 

**Expected output:**

`[55/73b81a] process > SayHello (1) [100%] 1 of 1 ✔
Hello world!

Hello world!`

**Hints:**

- A directive is stated inside a process.
- An output block follows the pattern:

`output: <output qualifier> <output name> into <target channel>[,channel,..]`.
- The output qualifier to catch the outputs from the command `echo` is `stdout`.

**Question 4:** Explore the outputs:
- Find two ways to access the pre-trimming HTML reports generated by FastQC.
- Which are the files generated by the second process named `alignment`? 
- Which are the files generated by the process named `quantification`? Open them and give and try to interpret the results.
- What is the name of the gene corresponding to the Ensembl gene ID "ENSG00000141510.11"? What are its functions?

## Create your own pipeline
You will create a pipeline aiming at mapping RNAseq paired reads to a reference genome.

**Question 5:** [Salmon](https://salmon.readthedocs.io/en/latest/) will be used as a pseudo aligner tool.
<ol>
<li> Create an `environment.yml` file specifying that Salmon is requested. 
<li> To use the command <code>-profile conda</code>, you should create a <code>nextflow.config</code> file.
</ol>

**Hints:**

- Have a glance at the corresponding files on the [Iarc RNAseq_Github repository](https://github.com/IARCbioinfo/RNAseq-nf)

**Question 6:** Create a Nextflow script allowing indexing the reference genome with Salmon.
- Use the directive `publishDir` to **copy** the output files in a folder named `INDEX`;
- The input declarative block targets the reference genome file;
- The output declarative block creates a channel receiving the outputs from Salmon.

**Hints:**

- The reference genome is in "data_test/REF/ctat_genome_lib_build_dir_TP53/ref_genome.fa";
- Have a glance at [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir) documentation.
- The qualifier of the output channel should be `file` or `path`.

**Question 6:** Create a Nextflow script to quantify the sets of paired reads using Salmon:
- Write a new process in the previous script;
- The output from the indexing process must be convert into a parameter;
- Create a directive specifying the number of cpus to use;
- The output files should be in a directory named `Alignments`

**Expected outputs:**

`N E X T F L O W  ~  version 20.10.0
Launching `alignment_transcriptome.nf` [magical_franklin] - revision: 53a3dd9b56
executor >  local (4)
[46/7bdec3] process > IndexRef (1) [100%] 1 of 1 ✔
[93/3f625d] process > Mapping (1)  [100%] 3 of 3 ✔
`
**Hints:**

- A type of channel is named fromFilePairs :)!
- Salmon has an optional argument which is `--threads`.

**Question 7:** How many reads have been mapped for the sample NA06984_T_RG1?

**Question Bonus:**
Do you have a better idea than creating a prameter targetting the index folder? How can the output channel from the indexing process, can be used in order to run the quantification process **for each** sample?
