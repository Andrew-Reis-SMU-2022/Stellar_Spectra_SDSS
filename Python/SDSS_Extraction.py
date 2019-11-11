import pandas as pd
import sqlalchemy
from astropy.io import fits
from astropy.table import Table
import numpy as np

engine = sqlalchemy.create_engine('mssql+pyodbc://localhost/Stellar_Spectra?Trusted_Connection=True;driver=SQL+Server+Native+Client+11.0')

df_optical_search = pd.read_csv('valid_star_generator/sdss_simbad_joined.csv')
df_optical_search = df_optical_search[df_optical_search['type'] != np.nan]
bool_star_index = ['*' in str(x) for x in df_optical_search['type']]
df_optical_search = df_optical_search[bool_star_index]

for specObjID, mjd, plate, fiberID in zip(df_optical_search['specobj_id'], df_optical_search['mjd'], df_optical_search['plate'], df_optical_search['fiberid']):
    print(specObjID)
    fits_file = fits.open(f'https://dr15.sdss.org/sas/dr15/sdss/spectro/redux/26/spectra/lite/{plate:04}/spec-{plate:04}-{mjd}-{fiberID:04}.fits')

    df_coadd = Table(fits_file[1].data).to_pandas()
    df_coadd['specObjID'] = [specObjID for i in range(len(df_coadd.index))]
    df_coadd.to_sql('SDSS_spectra_stg', engine, if_exists='append', index=False)

    df_spzline = Table(fits_file[3].data).to_pandas()
    df_spzline['specObjID'] = [specObjID for i in range(len(df_spzline.index))]
    df_spzline.to_sql('SDSS_lines_stg', engine, if_exists='append', index=False)

