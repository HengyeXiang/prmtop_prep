# .prmtop file preparation
.prmtop file is commonly used in QM/MM simulation in CP2K or in classical MD simulation in Amber.<br>
This repository shows several scripts which would be helpful for preparing .prmtop files from .xyz files of solute and solvents. <br>
Excution order of the scripts: <br>
```xyz_to_pdb.sh``` -> ```PDBrf.py``` -> ```process_pdb_files.sh``` -> ```rplHetatm.sh``` -> ```comb_pdb_files.sh``` -> ```totalTop_tleap.in``` <sh>
