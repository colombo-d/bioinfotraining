#!/bin/bash
# count_reads.sh — count the reads and their mean length in every FASTQ file of data/raw

outfile="results/read_counts.tsv"                    # where the report goes

printf 'sample\tn_reads\tmean_len\n' > "$outfile"    # header: CHANGE 1 → one more column name

for fq in data/raw/*.fastq.gz                        # one round for each FASTQ file
do
    sample=$(basename "$fq" .fastq.gz)               # data/raw/SRR6357070_1.fastq.gz → SRR6357070_1
    lines=$(zcat "$fq" | wc -l)                      # count the lines of this file
    reads=$(( lines / 4 ))                           # 4 lines per read
    mean_len=$(zcat "$fq" | awk 'NR % 4 == 2 {s += length($0); n++} END {print s / n}')   # CHANGE 2 → mean read length (awk from L14)
    printf '%s\t%s\t%s\n' "$sample" "$reads" "$mean_len" >> "$outfile"                  # CHANGE 3 → one more %s and the new variable
    echo "done: $sample"                             # progress message on screen
done