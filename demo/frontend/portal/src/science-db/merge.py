#!/usr/bin/env python

import argparse
import pandas
import re
import datetime


# Define some constant values

JOIN_COLUMNS = [
    'RID', 'PTID', 'VISCODE', 'EXAMDATE', 'PTGENDER', 'PTEDUCAT', 'MMSE'  # User those columns as join columns
]
JOIN_TYPE = "inner"  # Use a left outer join to merge data-frames
SCAN_TO_EXAM_DAYS_LIMIT = 30  # Max number of days allowed between scan date and exam date


# Parse command line arguments

args_parser = argparse.ArgumentParser()
args_parser.add_argument("input1")
args_parser.add_argument("input2")
args_parser.add_argument("output")
args = args_parser.parse_args()


# Read input CSV files to create Pandas data-frames

df1 = pandas.DataFrame.from_csv(args.input1, index_col=False)  # ADNIMERGE data
df2 = pandas.DataFrame.from_csv(args.input2, index_col=False, sep=";")  # Neuromorphometrics data


# Remove baseline columns except DX_bl from ADNIMERGE

col_names = list(df1.columns.values)
for col in col_names:
    if re.compile("(.*_bl)").match(col) and col != "DX_bl":
        df1.drop(col, axis=1, inplace=True)


# Convert dates from YYYY-MM-DD to DD.MM.YYYY format in ADNIMERGE

for index, row in df1.iterrows():
    day = re.search(r'\d+-\d+-(\d+)', row['EXAMDATE']).group(1)
    month = re.search(r'\d+-(\d+)-\d+', row['EXAMDATE']).group(1)
    year = re.search(r'(\d+)-\d+-\d+', row['EXAMDATE']).group(1)
    df1.loc[index, 'EXAMDATE'] = day + "." + month + "." + year


# Only keep baseline VISCODE rows in both ADNIMERGE and Neuromorphometrics data and remove rows with empty EXAMDATE

df1 = df1[df1["VISCODE"] == "bl"]
df2 = df2[df2["VISCODE"] == "bl"]
df1 = df1[df1["EXAMDATE"] != ""]
df2 = df2[df2["EXAMDATE"] != ""]


# Merge the data-frames

df3 = pandas.merge(df1, df2, how=JOIN_TYPE, on=JOIN_COLUMNS).drop_duplicates()
df3['Visit Number'].fillna(0, inplace=True)  # As VisitNumber must be part of the output PK, we fill empty cells with 0s


# Rename DX_bl to DX, Conversion to Conversion_bl and AGE to AGE_bl

df3.drop("DX", axis=1, inplace=True)
df3.rename(columns={'DX_bl': 'DX'}, inplace=True)
df3.rename(columns={'Conversion': 'Conversion_bl'}, inplace=True)


# Remove rows with an EXAMDATE to Scan Date period of more than one month

for index, row in df3.iterrows():
    exam_date = datetime.datetime.strptime(row["EXAMDATE"], "%d.%m.%Y")
    scan_date = datetime.datetime.strptime(row["Scan Date"], "%d.%m.%Y")
    if exam_date - scan_date > datetime.timedelta(days=SCAN_TO_EXAM_DAYS_LIMIT):
        df3.drop(index, inplace=True)


# Add conversion column to the output data-frame

df2 = pandas.DataFrame.from_csv(args.input2, index_col=False, sep=";")  # Re-open original Neuromorphometrics data
df3["Conversion"] = ""

for index, row in df3.iterrows():
    rid = row['RID']
    print("Searching conversion for " + str(rid))

    conv = None
    for i, r in df2.iterrows():
        if r['RID'] == rid:
            current_conv = r['Conversion']
            if not pandas.isnull(current_conv) and (re.compile(".+ to .+").match(current_conv) or not conv):
                conv = current_conv

    df3.loc[index, "Conversion"] = conv


# Export the result data-frame into a CSV file

df3.to_csv(args.output, index=False)
