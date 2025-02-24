#!/bin/bash

# Define the suffixes
suffixes=("aldehyde_v1" "ylide_v1" "solvent_v1" "solvent_top_v1")

# Function to replace 'HETATM' with 'ATOM  '
replace_hetatm_with_atom() {
    local file=$1
    
    # Use sed to replace 'HETATM' with 'ATOM  ' and ensure the same length
    sed -i 's/^HETATM/ATOM  /' "$file"
}

# Find PDB files that end with the specified suffixes
for suffix in "${suffixes[@]}"; do
    for file in *"$suffix".pdb; do
        # Check if the file exists to handle cases with no matching files
        if [[ -e "$file" ]]; then
            echo "Processing $file to replace HETATM with ATOM..."
            replace_hetatm_with_atom "$file"
            echo "$file has been processed."
        else
            echo "No files found for suffix $suffix"
        fi
    done
done

echo "All files processed."
