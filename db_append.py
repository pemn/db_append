#!python
# append multiple tables
# also works as file conversion between supported formats
# the result will contain all globally existing columns
# v1.0 08/2019 paulo.ernesto
'''
usage: $0 input#file*csv,xlsx,shp,dgd.isis,isis,00t,bmf,dm,msh output*csv,xlsx,shp,dgd.isis,isis,00t
'''
import sys, os.path
import pandas as pd
import numpy as np

# import modules from a pyz (zip) file with same name as scripts
sys.path.append(os.path.splitext(sys.argv[0])[0] + '.pyz')

from _gui import usage_gui, pd_load_dataframe, pd_save_dataframe

def db_append(input_path, output_path):
  odf = None
  for i_path in input_path.split(';'):
    print(i_path)
    idf = pd_load_dataframe(i_path)
    idf['filename'] = os.path.basename(i_path)
    if odf is None:
      odf = idf
    else:
      odf = odf.append(idf)

  pd_save_dataframe(odf, output_path)

main = db_append

if __name__=="__main__":
  usage_gui(__doc__)
