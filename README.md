# NextFlowClassesINSA
## Installation of NextFlow
Follow the instruction given at : 

https://seqera.io/training/

you should at least have :

 - Java from v8 to v12
 - Curl 
 - Nextflow

 To install NextFlow you just need to run the following command :

`curl get.nextflow.io | bash`

Move NextFlow to your bin directory and update the path.

To be sure that NextFlow has been add to your path in a terminal run:

`nextflow info`


## Check your installation
To check that Nextflow is correctly installed on machine run hello.nf with the following command:

`nextflow run hello.nf`

The expected output is:

`
executor >  local (3)
[b4/3c88c0] process > splitLetters (1)   [100%] 1 of 1 ✔
[18/f3d3f8] process > convertToUpper (1) [100%] 2 of 2 ✔
WORLD!
HELLO

`

## Analysis of RNA Seq data
### Step 1: Get a Fastq file of transcriptomic data
#### Option 1: Using fromSRA Channel

In order to do so:
+ Create a NCBI account: https://www.ncbi.nlm.nih.gov/account/?back_url=https%3A%2F%2Fwww.ncbi.nlm.nih.gov%2Fsra%2Fdocs%2Fsubmitformats%2F

+ Generate API key: going into your personal space


**Update `get_fastq_from_SRA.nf` script**

+ Modify the value of the paramater line 1 with your personal NCBI API Key.
+ Choose a sample ID of your choice from the project "Transcriptomic profiling of human Lung Carcinoids (LCs)" at https://www.ncbi.nlm.nih.gov//sra/?term=SRP156394. Example of sample ID: **SRR7646230** (Lu-Aty3 Atypical Carcinoids (ACs)). 
+ Modify the line 3 with the sample ID of your choice
+ Run the followig command line: 

`nextflow run get_fastq_from_SRA.nf 

You could also redefine the parameter value in the command line running:

`nextflow run get_fastq_from_SRA.nf  --ncbi_api_key  '0123456789`

**WARNING** To run this script you must have Nextflow 20.09 >

#### Option 2: Using SRAToolkit
- Download SRAToolkit at:

https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software

- Extract the archive
- Edit your paths adding a path toward the binary folder of SRAToolkit
- Choose a sample ID of your choice from the project "Transcriptomic profiling of human Lung Carcinoids (LCs)" at https://www.ncbi.nlm.nih.gov//sra/?term=SRP156394. Example of sample ID: **SRR7646230** (Lu-Aty3 Atypical Carcinoids (ACs)). 
- Download the SRA file : 

For example at:
https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR7646230

Download the SRA file cliking on the link: https://sra-download.ncbi.nlm.nih.gov/traces/sra69/SRR/007467/SRR7646230

**WARNING** Be sure that you have enough memory one transcriptome = 13GB! 

**Run `sra_to_fastq.nf` script**
- Create a data folder in your working directory.
- Move your SRA file into it. Optionally add the extension ".sra" to the SRA file. (*Modify or not the channel value defined line 3 in consequence.*)
- Run : `nextflow run sra_to_fastq.nf -process.echo`
- Output:

`
N E X T F L O W  ~  version 20.07.1
Launching `sra_to_fastq.nf` [confident_knuth] - revision: 8ef02477bc
executor >  local (1)
[4d/02000d] process > SRAToFastq (1) [100%] 1 of 1 ✔
Read 101597658 spots for SRR7646230.sra
Written 101597658 spots for SRR7646230.sra

Completed at: 26-sept.-2020 18:16:24
Duration    : 14m 34s
CPU hours   : 0.2
Succeeded   : 1
`


In my case if I go in the folder 4d/02000d... you will see the generated fastq.

`
ls work/4d/02000d2b1dbd61f544bfc295b25ee9/ && head -3 work/4d/02000d2b1dbd61f544bfc295b25ee9/*.fastq
`

Output:

`
SRR7646230.fastq	SRR7646230.sra
@SRR7646230.1 HS2000-1241:190:C28W3ACXX:1:1101:4025:2247 length=200
GCAGAATAGAGGGGTCTGGGACATGGACCCAGACTAAACCAGCCATCCTGGAGGGCAGGCATCAGGGTGGGGCTGAAAGCCCCGATCCCACTCTGGGAATGGCCGGAGGGACCCCAGACCTTCAGAGGGCTGCCCTGGTGTTCTCCACAGTGCAGTCCCTCTGTATTCCCAGAGTGGGATCGGGGCTTTCAGCCCCACCC
+SRR7646230.1 HS2000-1241:190:C28W3ACXX:1:1101:4025:2247 length=200






