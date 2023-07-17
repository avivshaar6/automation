# Create NSX-T DFW base on csv file - Automation for micro-segmentation projects

This script is designed to create a DFW section and rules in the NSX-T base on the vRNI recommendation firewall rules in the CSV file.

## Key technology used

1. Python

## Prerequisite:

1. Install Python.

## Explanation of the code

The codes Consist of:
- Python:
    Configure environment variable:
    1. NSX_ENDPOINT
    2. CSV_FILE_PATH

a. The script checks if the port was created and if not it creates the new ports.
b. The script goes through the csv on the source column and checks if there is such a section, if not it creates and puts the rules.

For example:

This is a CSV of vRNI output:


after run the script it will create the DFW section and rules:
