--DROP TABLE SDSS_spectra

SELECT specObjID,
	POWER(10.0, loglam) / 10 AS obsWavelength,
	(POWER(10.0, loglam) / 10) / SQRT((1 + z)/(1 - z)) AS sourceWavelength,
	model AS modelFlux,
	z AS Beta
	INTO SDSS_spectra
  FROM [Stellar_Spectra].[dbo].[SDSS_spectra_stg]
  INNER JOIN SDSS_optical_search ON specObjID = specobj_id
  WHERE specObjID IN (SELECT specobj_id
  FROM [Stellar_Spectra].[dbo].[SDSS_optical_search]
  WHERE subclass NOT LIKE '%WD%' AND type NOT LIKE '%WD%' AND zwarning = 0 AND [#bib] >= 5)