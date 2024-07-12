#!/bin/bash

# Directory where the files will be created
DIR="/workspace/was/s3/batch-operations/files"

# Create directory if it does not exist
mkdir -p $DIR

# Loop to create 20 files
for i in {1..20}; do
    # Generate a random size between 1 and 1000 bytes
    SIZE=$((RANDOM % 1000 + 1))
    
    # Create a file with the determined size
    dd if=/dev/zero of="${DIR}/file_$i" bs=1 count=$SIZE 2>/dev/null
done

echo "20 files created in $DIR"