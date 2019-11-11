import pandas as pd
import numpy as np

def removeExtraSpaces(text):
    splits = text.split(' ')
    result = ''
    for split in splits:
        if split != '':
            result += split + ' '
    return result[:-1] #don't include the final space

df_os = pd.read_csv('valid_star_generator/optical_search_0.001.csv')

df_sim = {'identifier': [], 'type': [], '#bib': [], '#not': []}

with open('valid_star_generator/simbad.txt') as simbad_fin:
    #read past metadata
    simbad_fin.readline()
    simbad_fin.readline()

    line = simbad_fin.readline()
    while line != '':
        if line == '\n': #avoid logic below for empty lines
            pass
        elif line[:5] == 'coord':
            print(line)
            for i in range(6):
                simbad_fin.readline()
            line = simbad_fin.readline()
            data = line.split('|')
            df_sim['identifier'].append(removeExtraSpaces(data[2]))
            df_sim['type'].append(data[3].replace(' ', ''))
            df_sim['#bib'].append(int(data[11].replace(' ','')))
            df_sim['#not'].append(int(data[12].replace(' ', '')))
        elif 'No astronomical object found' in line:
            print(line)
            df_sim['identifier'].append(np.nan)
            df_sim['type'].append(np.nan)
            df_sim['#bib'].append(np.nan)
            df_sim['#not'].append(np.nan)
        line = simbad_fin.readline()

df_os['identifier'] = df_sim['identifier']
df_os['type'] = df_sim['type']
df_os['#bib'] = df_sim['#bib']
df_os['#not'] = df_sim['#not']

df_os.to_csv('valid_star_generator/sdss_simbad_joined.csv')
