# bioinfotraining
Bash exercises for bioinformatics, run on public RNA-seq test data (*Saccharomyces cerevisiae*, nf-core test datasets).

## what's inside 
- `scripts/count_reads_v2.sh` — counts reads and mean read length for every FASTQ in a folder,
  with argument and error checks (`set -euo pipefail`)
- `results/` — tables produced during the exercises (read counts, GTF feature counts, BED files)
- `environment.yml` — conda environment with pinned tool versions

## Reproduce

```bash
# 1. create the environment
mamba env create -f environment.yml
conda activate bash-course-test

# 2. download the data (not stored in this repo, see .gitignore)
mkdir -p data/raw
wget -P data/raw https://raw.githubusercontent.com/nf-core/test-datasets/rnaseq/testdata/GSE110004/SRR6357070_1.fastq.gz
wget -P data/raw https://raw.githubusercontent.com/nf-core/test-datasets/rnaseq/testdata/GSE110004/SRR6357070_2.fastq.gz
wget -P data/raw https://raw.githubusercontent.com/nf-core/test-datasets/rnaseq/testdata/GSE110004/SRR6357071_1.fastq.gz
wget -P data/raw https://raw.githubusercontent.com/nf-core/test-datasets/rnaseq/reference/genes.gtf.gz

# 3. run
./scripts/count_reads_v2.sh data/raw results/read_counts.tsv
```

## Skills practised

Shell navigation, pipes and redirection, `grep`, `cut`/`sort`/`uniq`,
`awk`, `sed`, bash scripting, conda environments, git.