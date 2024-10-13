import pandas as pd

rule split:
    input:
        bed_a="shuf.a.bed.gz",
        bed_b="shuf.b.bed.gz",
    output:
        "split_individual/{chr}.bed.gz"
    shell:
        "(zcat {input.bed_a} | awk '$1==\"{wildcards.chr}\"'; zcat {input.bed_b} | awk '$1==\"{wildcards.chr}\"') | gzip > {output}"

rule sort:
    input:
        "split_individual/{chr}.bed.gz"
    output:
        "sort_individual/{chr}.bed.gz"
    shell:
        "zcat {input} | sort -k2,2n -k3,3n | gzip > {output}"

rule combine:
    input:
        sorted_files=expand("sort_individual/{chr}.bed.gz", chr=pd.read_csv("standard_selection.tsv", header=None)[0]),
        order="standard_selection.tsv"
    output:
        "sorted_bed_file_per_sample/X_sorted.bed.gz"
    shell:
        "while read chr; do zcat sort_individual/${{chr}}.bed.gz; done < standard_selection.tsv | gzip > sorted_bed_file_per_sample/X_sorted.bed.gz"
