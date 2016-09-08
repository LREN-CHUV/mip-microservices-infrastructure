# ADNI merge Database


## What is it about ?

This project contains original 'ADNIMERGE.csv' and 'ADNI_Data_Volumes_Neuromorphometric_withTIV.csv' files (in the 'original' folder). 
It also contains a Python script ('merge.py') which aims to merge the files and only keep one row per participant ('sql/values.csv'). 
The merge result file can be used to populate a PostgreSQL database. 
Finally, this project contains a file that lists all the available variables with a description (['code', 'label', 'description']).


## How to use the merge script

Run: `./merge.py <adni-merge_file> <neuromorphometrics_file> <output>`. 
Example: `./merge.py original/ADNIMERGE.csv original/ADNI_Data_Volumes_Neuromorphometric_withTIV.csv sql/values.csv` 
This will clean the data and operate an inner join using those join columns: ['RID', 'PTID', 'VISCODE', 'EXAMDATE', 'PTGENDER', 'PTEDUCAT', 'MMSE']. 
It will ensure that no duplicate row exists and fill the 'Visit Number' column empty field with 0s in order to use it as part of the output primary key.


## Data cleaning

Here are some steps:

* Remove baseline variables (ending with "_bl") from ADNIMERGE except DX_bl
* Convert dates to use the same format in both files
* Rename DX_bl to DX
* Only keep rows with VISCODE=bl and with "Scan Date - EXAMDATE < 1 month"


## ADNI data privacy

As the ADNI data is not redistributable, we keep this information internally.

