
select * 
  FROM [Data Cleaning].[dbo].[Nashivile Housing];



  select SaleDate
  FROM [Data Cleaning].[dbo].[Nashivile Housing];
  --Question 1
  -- Creating new date column with date format in the table, updating the column with the converted date from the original date
 Alter Table [dbo].[Nashivile Housing]
 Add New_Date Date;

 Update [dbo].[Nashivile Housing]
 Set New_Date = CONVERT(Date, SaleDate); 


select New_Date from [Data Cleaning].[dbo].[Nashivile Housing];


-- Question 2
 -- Using a self join to populate property address where parcel address is the same but uniqueID is different
select PropertyAddress 
	from [Data Cleaning].[dbo].[Nashivile Housing]
where PropertyAddress is null;


 select * 
	from [Data Cleaning].[dbo].[Nashivile Housing]
where PropertyAddress is null;


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) -- is null 4 filling propertyaddress(a) that is null with propertyaddress(b)
	from [Data Cleaning].[dbo].[Nashivile Housing] a
JOIN [Data Cleaning].[dbo].[Nashivile Housing] b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;


 Update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Data Cleaning].[dbo].[Nashivile Housing] a
JOIN [Data Cleaning].[dbo].[Nashivile Housing] b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;


select *
from [Data Cleaning].[dbo].[Nashivile Housing]
where PropertyAddress is null;

-- Question 3	
-- Breaking down the property address into address and City
select PropertyAddress,
CHARINDEX(',', PropertyAddress) as Space_Position -- To check for position of values
from [Data Cleaning].[dbo].[Nashivile Housing];

select LEN(PropertyAddress) as P_Length   -- To check for length of each row in a column
from [Data Cleaning].[dbo].[Nashivile Housing];

-- Substring is used for extracting strings or values from a given string based on specified condition
select PropertyAddress,
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as address
from [Data Cleaning].[dbo].[Nashivile Housing];


select PropertyAddress,
Substring(propertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as City
from [Data Cleaning].[dbo].[Nashivile Housing];



 Alter Table [dbo].[Nashivile Housing]
 Add New_City nvarchar(255) ;

 Update [dbo].[Nashivile Housing]
 Set New_City = Substring(propertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) 



 Alter Table [dbo].[Nashivile Housing]
 Add New_Address Nvarchar(255);

 Update [dbo].[Nashivile Housing]
 Set New_Address  = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)



 -- Question 4
 -- Breaking the ownersAddress into three parts using PARSENAME
 select ownerAddress,
 PARSENAME(Replace(OwnerAddress, ',', '.'), 3),
  PARSENAME(Replace(OwnerAddress, ',', '.'), 2),
   PARSENAME(Replace(OwnerAddress, ',', '.'), 1)
 from [Data Cleaning].[dbo].[Nashivile Housing];



 Alter Table [dbo].[Nashivile Housing]
 Add Owner_Address nvarchar(255) ;

 Update [dbo].[Nashivile Housing]
 Set Owner_Address = PARSENAME(Replace(OwnerAddress, ',', '.'), 3)

 Alter Table [dbo].[Nashivile Housing]
 Add Owner_City nvarchar(255) ;

 Update [dbo].[Nashivile Housing]
 Set Owner_City =  PARSENAME(Replace(OwnerAddress, ',', '.'), 2)


  Alter Table [dbo].[Nashivile Housing]
 Add Owner_State nvarchar(255) ;

 Update [dbo].[Nashivile Housing]
 Set Owner_State = PARSENAME(Replace(OwnerAddress, ',', '.'), 1)


 select *
 from [Data Cleaning].[dbo].[Nashivile Housing];

 
 -- Question 5
 -- Replacing Y with YES and N with NO in SoldVacant Column 

 select distinct(SoldAsVacant),
 count(SoldAsVacant)
 from [Data Cleaning].[dbo].[Nashivile Housing]
 Group by SoldAsVacant;



 select SoldAsVacant,
 CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	  WHEN SoldAsVacant = 'N' THEN 'NO'
	  ELSE SoldAsVacant
	  END
 from [Data Cleaning].[dbo].[Nashivile Housing]


 Update [Nashivile Housing]
 SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	  WHEN SoldAsVacant = 'N' THEN 'NO'
	  ELSE SoldAsVacant

	  END



-- Question 6
-- Remove Duplicates

WITH RowNumCTE AS (
select *, 
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num


	from [Data Cleaning].[dbo].[Nashivile Housing]
)
 select *
 from RowNumCTE
 Where row_num > 1
 Order by PropertyAddress;



 -- Question 7
 --- Deleting Unused Column

 
 Alter Table [Data Cleaning].[dbo].[Nashivile Housing]
 Drop Column OwnerAddress, TaxDistrict, PropertyAddress;

 Alter Table [Data Cleaning].[dbo].[Nashivile Housing]
 Drop Column SaleDate;

 select *
 from [Data Cleaning].[dbo].[Nashivile Housing];