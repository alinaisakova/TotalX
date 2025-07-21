# TotalX: Scalable Single-cell Total RNA-seq

**Authors:** Alina Isakova et al.

## Overview

TotalX is a robust, scalable framework for single-cell total RNA profiling that enables detection of both polyadenylated and non-polyadenylated transcripts—including miRNAs, lncRNAs, tRNAs, snoRNAs, snRNAs, and histone RNAs—at high throughput and with minimal protocol changes to the standard 10x Genomics platform.

> **Figure 1A.** Overview of the TotalX protocol and benchmarking against other single-cell RNA-seq methods:

![Figure 1A: Overview of TotalX protocol](Git_fig1.png)

*Figure 1A shows the workflow: enzymatic polyadenylation, reverse transcription with a custom TSO, Cas9-based rRNA depletion, separation of long/short cDNA, optional miRNA enrichment, and high-throughput sequencing. Panels b–f show benchmarking against VASA-seq and 10x Genomics 3', gene detection rates, RNA biotype diversity, miRNA detection, and read coverage profiles for selected miRNAs. See manuscript for details.*

## Method Description

TotalX adapts the Smart-seq-total principles to droplet-based 10x Genomics 3′ chemistry, using a custom template-switching oligo (TSO) and uracil-DNA glycosylase (UDG) for cDNA processing, with Cas9-mediated rRNA depletion (DASH).  
- Both long (>400 bp) and short (<400 bp) RNA fragments are indexed and sequenced in parallel, with optional miRNA enrichment.
- Compatible with standard Cell Ranger pipelines and high-throughput 10x workflows.
- Recovers diverse RNA biotypes at single-cell resolution.

TotalX achieves gene detection sensitivity comparable to VASA-seq but at 10x droplet scale, enabling the discovery of non-coding RNAs (lncRNAs, miRNAs, tRNAs, snoRNAs, etc.) across thousands of cells per experiment.  
This enables new studies of coding and non-coding programs in immunity, infection, and brain development.

---

## How to Use

*(Add installation, code, or links here)*

---

## Citation

*(Add your citation info)*

---

## More Information

For full details, see the [preprint/manuscript](link), or contact [your email].


