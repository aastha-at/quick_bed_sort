# quick_bed_sort

1. Activate environment for quick_bed_sort
mamba activate quick_bed_sort
2. Ensure you have all input files:
shuf.a.bed.gz shuf.b.bed.gz standard_selection.tsv
3. Run the Snakemake file.
snakemake -j1 sorted_bed_file_per_sample/final_sorted.bed.gz --snakefile quick_bed_sort.smk
