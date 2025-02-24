#!/bin/bash

# Define the suffixes
suffixes_1=("aldehyde_v1" "ylide_v1" "solvent_v1")
suffixes_2=("aldehyde_v1" "ylide_v1" "solvent_top_v1")

# Output file
output_file_1="total_wtin.pdb"
output_file_2="total_top.pdb"

# Clear the output file if it exists
> "$output_file_1"
> "$output_file_2"

# Loop through each suffix and concatenate files
for suffix in "${suffixes_1[@]}"; do
    for file in *"$suffix".pdb; do
        # Check if the file exists to handle cases with no matching files
        if [[ -e "$file" ]]; then
            echo "Adding $file to $output_file_1..."
            cat "$file" >> "$output_file_1"
        else
            echo "No files found for suffix $suffix"
        fi
    done
done

echo "All files have been concatenated into $output_file_1."

for suffix in "${suffixes_2[@]}"; do
    for file in *"$suffix".pdb; do
        # Check if the file exists to handle cases with no matching files
        if [[ -e "$file" ]]; then
            echo "Adding $file to $output_file_2..."
            cat "$file" >> "$output_file_2"
        else
            echo "No files found for suffix $suffix"
        fi
    done
done


echo "All files have been concatenated into $output_file_2."


# Define the new directory
new_directory="older_versions"

# Create the new directory if it does not exist
if [ ! -d "$new_directory" ]; then
    mkdir "$new_directory"
    echo "Directory $new_directory created."
else
    echo "Directory $new_directory already exists."
fi

# Define the patterns to search for
patterns=("aldehyde" "ylide" "solvent")

# Loop through each pattern and move matching files
for pattern in "${patterns[@]}"; do
    for file in *"$pattern"*; do
        # Check if the file exists to handle cases with no matching files
        if [ -e "$file" ]; then
            echo "Moving $file to $new_directory..."
            mv "$file" "$new_directory/"
        else
            echo "No files found for pattern $pattern"
        fi
    done
done

echo "All matching files have been moved to $new_directory."

