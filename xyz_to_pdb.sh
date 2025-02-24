#!/bin/bash

module load intel/2017.1.132
module load openbabel/3.1.1

# Loop through each .xyz file in the current directory
for file in *.xyz; do
    # Check if any .xyz files exist
    if [[ -e "$file" ]]; then
        # Define the output file name by replacing .xyz with .pdb
        output_file="${file%.xyz}.pdb"
        
        # Convert the .xyz file to .pdb format using OpenBabel
        obabel -ixyz "$file" -opdb > "$output_file"
        
        # Check if the conversion was successful
        if [[ $? -eq 0 ]]; then
            echo "Successfully converted $file to $output_file."
        else
            echo "Failed to convert $file."
        fi
    else
        echo "No .xyz files found in the current directory."
        break
    fi
done

echo "Conversion process completed."
