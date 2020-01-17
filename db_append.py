#!python
# append rows of multiple tables and include all columns
# also works as file conversion between supported formats
# input formats: csv,xlsx,shp,msh,00t,dgd.isis,isis,bmf,dm
# output formats: csv,xlsx,shp,msh,00t,dgd.isis
# v1.0 08/2019 paulo.ernesto
'''
usage: $0 input#file*csv,xlsx,shp,msh,00t,dgd.isis,isis,bmf,dm output*csv,xlsx,shp,msh,00t,dgd.isis
'''
'''
Copyright 2017 Vale

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

*** You can contribute to the main repository at: ***

github.com/pemn/db_append
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
