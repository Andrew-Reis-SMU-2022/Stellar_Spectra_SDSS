USE [Stellar_Spectra]
GO

/****** Object:  View [dbo].[vw_SDSS_optical_search]    Script Date: 11/10/2019 11:27:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vw_SDSS_optical_search] AS 
SELECT [plate]
      ,[mjd]
      ,[fiberid]
      ,[run2d]
      ,[specobj_id]
      ,[ra]
      ,[dec]
      ,[sn_median_r]
      ,[z]
      ,[zerr]
      ,[zwarning]
      ,[class]
      ,[subclass]
      ,[identifier]
      ,[type]
      ,[#bib]
  FROM [Stellar_Spectra].[dbo].[SDSS_optical_search]
  WHERE subclass NOT LIKE '%WD%' AND type NOT LIKE '%WD%' AND zwarning = 0 AND [#bib] >= 5
GO


