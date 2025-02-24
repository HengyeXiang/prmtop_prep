import os
import numpy as np
import math
import sys
import glob
# import pandas as pd

files = ["aldehyde.pdb", "ylide.pdb", "solvent.pdb", "solvent_top.pdb"]

def process_files(atoms_solvents):
    
    for file in files:
        with open(file, 'r') as f:
            lines = f.readlines()

        # Ignore the first two lines
        content = lines[2:]
        
        # Find the index where 'CONECT' starts
        conect_index = next((i for i, line in enumerate(content) if line.startswith("CONECT")), len(content))

        # Extract lines to process (excluding 'CONECT' lines)
        data_lines = content[:conect_index]
        
        if file == "aldehyde.pdb":
            # Just write the data back to a new file (or overwrite)
            with open("new_aldehyde.pdb", 'w') as f:
                # f.writelines(lines[:2])  # Write first two lines
                f.writelines(data_lines)  # Write processed lines
                # f.writelines(content[conect_index:])  # Write CONECT lines
        elif file == "ylide.pdb":
            # Modify the fifth column to 2
            modified_lines = [modify_fifth_column(line, 2) for line in data_lines]
            with open("new_ylide.pdb", 'w') as f:
                # f.writelines(lines[:2])  # Write first two lines
                f.writelines(modified_lines)  # Write modified lines
                # f.writelines(content[conect_index:])  # Write CONECT lines
        elif file in ["solvent.pdb", "solvent_top.pdb"]:
            # Modify the fifth column based on atoms_solvents
            modified_lines = modify_solvent_columns(data_lines, atoms_solvents)
            new_file_name = "new_" + file
            with open(new_file_name, 'w') as f:
                # f.writelines(lines[:2])  # Write first two lines
                f.writelines(modified_lines)  # Write modified lines
                # f.writelines(content[conect_index:])  # Write CONECT lines


def modify_fifth_column(line, value):
    parts = line.split()
    int_val = int(value)
    if (int_val<10):
        return line[:25] + str(value) + line[26:]
    elif (int_val >=10 and int_val <100):
        return line[:24] + str(value) + line[26:]
    elif (int_val >= 100 and int_val <1000):
        return line[:23] + str(value) + line[26:]
    

def modify_solvent_columns(lines, atoms_solvents):
    modified_lines = []
    increment_value = 3
    for i, line in enumerate(lines):
        modified_line = modify_fifth_column(line, increment_value)
        if (i + 1) % atoms_solvents == 0:
            increment_value += 1
        modified_lines.append(modified_line)
    return modified_lines


def rm_org_files():
    for file in files:
        try:
            os.remove(file)
            print(f"Removed {file} successfully.")
        except FileNotFoundError:
            print(f"{file} not found. Skipping removal.")


atm_solvt = 13


length = len(sys.argv)
if (length > 1):
        for k in range(length):
            if(sys.argv[k] == '-as'):
                atm_solvt = int(sys.argv[k+1])

                
# Run the script
process_files(atm_solvt)

rm_org_files()



