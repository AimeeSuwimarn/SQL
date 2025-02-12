SELECT TOP (1000) [Suburb]
      ,[Address]
      ,[Rooms]
      ,[Type]
      ,[Price]
      ,[Method]
      ,[SellerG]
      ,[Date]
      ,[Distance]
      ,[Postcode]
      ,[Bedroom2]
      ,[Bathroom]
      ,[Car]
      ,[Landsize]
      ,[BuildingArea]
      ,[YearBuilt]
      ,[CouncilArea]
      ,[Lattitude]
      ,[Longtitude]
      ,[Regionname]
      ,[Propertycount]
      ,[SalesDate]
      ,[SaleDate]
  FROM [MelbHousing].[dbo].[Melbhousing]


--Cleaning data in SQL

Select *
From MelbHousing.dbo.Melbhousing

--Standardize data format

Select SaleDateConverted, CONVERT(Date,[Date]) As Sale_Date
From MelbHousing.dbo.Melbhousing

Update MelbHousing
Set SaleDate = CONVERT(Date,[Date]) As Sale_Date

Alter Table MelbHousing
Add SaleDateConverted Date;

Update MelbHousing
Set SaleDateConverted = CONVERT(Date,[Date]) 


--Populate Property Address Data

Select *
From MelbHousing.dbo.Melbhousing
---Where Postcode is null
Order by Postcode

-- Breaking out address, Create new column
Select 
SUBSTRING(Melbhousing.Address, 1, CHARINDEX(' ', Melbhousing.Address)) as HouseNumber,
SUBSTRING(Melbhousing.Address, CHARINDEX(' ', Melbhousing.Address) + 1 , LEN(Melbhousing.Address)) as Street
From MelbHousing.dbo.Melbhousing

Alter Table MelbHousing.dbo.Melbhousing
Add HousingNumber Nvarchar(200);

Update MelbHousing.dbo.Melbhousing
Set HousingNumber = SUBSTRING(Melbhousing.Address, 1, CHARINDEX(' ', Melbhousing.Address))

Alter Table MelbHousing.dbo.Melbhousing
Add StreetName Nvarchar(200);

Update MelbHousing.dbo.Melbhousing
Set StreetName = SUBSTRING(Melbhousing.Address, CHARINDEX(' ', Melbhousing.Address) + 1 , LEN(Melbhousing.Address)) 

Select *
From MelbHousing.dbo.Melbhousing

--Change House type from h u t to house unit townhouse
Select Type, count(type)
From MelbHousing.dbo.Melbhousing
Group by type

Select type
, Case When Type = 't' Then 'Townhouse'
       When Type = 'h' Then 'House'
	   When Type = 'u' Then 'Unit'
	   End
From MelbHousing.dbo.Melbhousing

Update Melbhousing
Set Type = Case When Type = 't' Then 'Townhouse'
       When Type = 'h' Then 'House'
	   When Type = 'u' Then 'Unit'
	   End


--Remove Unsuse column

Select *
From MelbHousing.dbo.Melbhousing

ALTER TABLE MelbHousing.dbo.Melbhousing
DROP COLUMN HouseNumber, Street, SalesDate, SaleDateConverted
