USE [Stellar_Spectra]
GO

/****** Object:  View [dbo].[Stellar_Spectra]    Script Date: 11/10/2019 11:27:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[Stellar_Spectra] AS
SELECT SDSS_spectra.[specObjID]
      ,SDSS_spectra.[obsWavelength]
      ,SDSS_spectra.[sourceWavelength]
      ,[modelFlux]
      ,SDSS_spectra.[Beta]
	  ,CASE WHEN lineName IS NOT NULL THEN lineName ELSE '' END AS lineName
	  ,CASE WHEN lineName IS NOT NULL THEN 1 ELSE 0 END AS lineIndicator
	  ,(2.898 * POWER(CAST(10 AS FLOAT), -3)) / (SDSS_spectra.[sourceWavelength] * POWER(CAST(10 AS FLOAT), -9)) AS wiensDisplacementTemp
  FROM [Stellar_Spectra].[dbo].[SDSS_spectra]
  LEFT OUTER JOIN SDSS_lines ON SDSS_lines.specObjID = SDSS_spectra.specObjID
  AND ABS(SDSS_spectra.obsWavelength - SDSS_lines.obsWavelength) < 0.5
GO


