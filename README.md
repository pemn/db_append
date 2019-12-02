# db_append
append and/or convert multiple files in supported formats

## Description  
This simple script leverages the multiple input/output filters available in the custom _gui (github.com/pemn/usage-gui) library to convert data between formats or just concatenate multipe files in a single output.  
Not all formats are valid for output or for concatenation.

## How to use
The simplest mode is a single input file for conversion.
Another simple mode is multiple simple files (like csv) and a single output file.
Some more complex mix are possible, but some formats may not produce a valid output when multiple files are joined together.

## Input Supported Formats
 - CSV
 - Excel XLSX
 - ESRI Shapefile
 - Vulcan Triangulation 00t
 - Vulcan BMF
 - Vulcan Isis Database
 - Datamine DM
 - Leapfrog Mesh

## Output Supported Formats
 - CSV
 - Excel XLSX
 - ESRI Shapefile
 - Vulcan Triangulation 00t
