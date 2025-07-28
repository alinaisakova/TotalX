#!/bin/bash

# Define the base directories containing the input files
INPUT_DIRS=("SMALL")  # Adjust as necessary
LOG_DIR="logs/"
# Convert input directories to absolute paths
for i in "${!INPUT_DIRS[@]}"; do
    INPUT_DIRS[$i]=$(realpath "${INPUT_DIRS[$i]}")
done


# SLURM job settings
MEMORY="1024"  # Memory in MB (1 GB)
NUM_CORES=1     # Number of cores
EMAIL="isakova@stanford.edu"  # Email for notifications

# Create the logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Step 1: Submit SLURM jobs for trimming
echo "Step 1: Submitting SLURM jobs for trimming..."

for input_dir in "${INPUT_DIRS[@]}"; do
    BASE_DIR=$(dirname "$input_dir")  # Get the base directory (e.g., 9MO/SMALL or 8YO/miRNA)
    TRIMMED_DIR="${BASE_DIR}/fastq_trimmed"
    mkdir -p "$TRIMMED_DIR"

    # Find all unique sample prefixes (without lane and read information)
    for R1_file in "$input_dir"/*_L001_R1_001.fastq.gz; do
        if [[ ! -e "$R1_file" ]]; then
            echo "No R1 files found in $input_dir"
            continue
        fi

        base_name=$(basename "$R1_file")
        sample_name="${base_name%%_L001_R1_001.fastq.gz}"

        echo "Processing sample: $sample_name"


        # Collect files for all lanes (L001, L002, L003, L004)
        for lane in L001 L002 L003 L004; do
            R1_lane_file="${input_dir}/${sample_name}_${lane}_R1_001.fastq.gz"
            R2_lane_file="${input_dir}/${sample_name}_${lane}_R2_001.fastq.gz"

            if [[ -e "$R1_lane_file" && -e "$R2_lane_file" ]]; then
                echo "Processing lane $lane for sample $sample_name"

                # Define output files for this lane
                TRIM_R1="${TRIMMED_DIR}/${sample_name}_${lane}_R1_001.fastq.gz"
                TRIM_R2="${TRIMMED_DIR}/${sample_name}_${lane}_R2_001.fastq.gz"

        # Submit job to scheduler using sbatch
            sbatch <<EOT
#!/bin/bash
#SBATCH --job-name=TRIM_${sample_name}
#SBATCH --output=${LOG_DIR}/${sample_name}.out
#SBATCH --error=${LOG_DIR}/${sample_name}.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=${NUM_CORES}
#SBATCH --mem=${MEMORY}M
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=${EMAIL}
#SBATCH --time=24:00:00

ml biology py-cutadapt
# Run cutadapt for trimming reads across all lanes
cutadapt -u 6 -a "AAAAAAAAAA;min_overlap=10" -m 18 -o ${TRIM_R2} -p ${TRIM_R1} "${R2_lane_file}" "${R1_lane_file}"
EOT

                echo "Job submitted for sample: $sample_name, lane: $lane"
            else
                echo "Missing files for lane $lane for sample $sample_name, skipping this lane..."
            fi
        done
    done
done


