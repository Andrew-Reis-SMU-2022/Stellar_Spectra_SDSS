--DROP TABLE SDSS_lines

SELECT specObjID,
		LINENAME AS lineName,
		LINEWAVE / 10 AS sourceWavelength,
		(LINEWAVE / 10) * SQRT((1 + z)/(1 - Z)) AS obsWavelength,
		z as Beta
		INTO SDSS_lines
  FROM [Stellar_Spectra].[dbo].[SDSS_lines_stg]
  INNER JOIN SDSS_optical_search ON specObjID = specobj_id
  WHERE specObjID IN (SELECT specobj_id
  FROM [Stellar_Spectra].[dbo].[SDSS_optical_search]
  WHERE subclass NOT LIKE '%WD%' AND type NOT LIKE '%WD%' AND zwarning = 0 AND [#bib] >= 5)