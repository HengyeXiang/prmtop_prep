#!/bin/bash

# Define the suffixes
suffixes=("aldehyde" "ylide" "solvent" "solvent_top")

# Function to process files based on suffix
process_file() {
    local file=$1
    local suffix=$2
    
    # Check the suffix and apply appropriate commands
    case $suffix in
        "aldehyde")
            # Change resname to ADH for aldehyde files
            pdb_uniqname "$file" | pdb_rplresname -UNL:ADH > "${file%.pdb}_v1.pdb"
            ;;
        "ylide")
            # Change resname to YLD for ylide files
            pdb_uniqname "$file" | pdb_rplresname -UNL:YLD | pdb_reatom -15 > "${file%.pdb}_v1.pdb"
            ;;
        "solvent")
            # Example command for solvent files
            pdb_uniqname "$file" | pdb_rplresname -UNL:THF | pdb_reatom -61 > "${file%.pdb}_v1.pdb"
            ;;
        "solvent_top")
            # Example command for solvent_top files
            pdb_uniqname "$file" | pdb_rplresname -UNL:THF | pdb_reatom -61 > "${file%.pdb}_v1.pdb"
            ;;
        *)
            echo "Unknown suffix: $suffix"
            return 1
            ;;
    esac
        
    echo "$file has been processed and converted."
}

# Find PDB files that end with the specified suffixes
for suffix in "${suffixes[@]}"; do
    for file in *"$suffix".pdb; do
        # Check if the file exists to handle cases with no matching files
        if [[ -e "$file" ]]; then
            echo "Processing $file with suffix $suffix..."
            process_file "$file" "$suffix"
        else
            echo "No files found for suffix $suffix"
        fi
    done
done

echo "All files processed."
