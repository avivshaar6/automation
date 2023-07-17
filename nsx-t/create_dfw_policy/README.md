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
![Screenshot 2023-07-17 at 10 33 58](https://github.com/avivshaar6/automation/assets/60941781/57b1a43e-b89c-43c2-bb3a-9f8e073f6b4b)


after running the script it will create the DFW section and rules:
![Screenshot 2023-07-17 at 10 48 03](https://github.com/avivshaar6/automation/assets/60941781/05ba4b57-a2a7-4ba6-bf3f-f7f19fefad6e)
