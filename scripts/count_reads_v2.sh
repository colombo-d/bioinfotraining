#!/bin/bash
# count_reads_v2.sh — count reads and mean length for every FASTQ in a given folder
# usage: count_reads_v2.sh INPUT_DIR OUTPUT_FILE

set -euo pipefail                      # stop at the first error (-e), on unset variables (-u), and if any part of a pipe fails (pipefail)

# --- check the arguments ---
if [ "$#" -ne 2 ]; then                # $# = number of arguments given; -ne = "not equal"
    echo "Usage: $0 INPUT_DIR OUTPUT_FILE" >&2   # $0 = the script's own name; >&2 = print to stderr
    exit 1                             # stop with an error code (0 = success, anything else = failure)
fi

indir="$1"                             # first argument: folder with the FASTQ files
outfile="$2"                           # second argument: where to write the report

if [ ! -d "$indir" ]; then             # -d = "is a directory"; ! = NOT
    echo "Error: folder '$indir' not found" >&2
    exit 1
fi

# --- main loop (same as L16, but reading from $indir) ---
printf 'sample\tn_reads\tmean_len\n' > "$outfile"

n_files=0                              # count how many files we process
for fq in "$indir"/*.fastq.gz
do
    if [ ! -e "$fq" ]; then            # -e = "exists": false when the wildcard matched nothing (the "done: *" bug of L16)
        echo "Error: no .fastq.gz files in '$indir'" >&2
        exit 1
    fi
    sample=$(basename "$fq" .fastq.gz)
    lines=$(zcat "$fq" | wc -l)
    reads=$(( lines / 4 ))
    mean_len=$(zcat "$fq" | awk 'NR % 4 == 2 {s += length($0); n++} END {print s / n}')
    printf '%s\t%s\t%s\n' "$sample" "$reads" "$mean_len" >> "$outfile"
    echo "done: $sample"
    n_files=$(( n_files + 1 ))
done

echo "Finished: $n_files files → $outfile"