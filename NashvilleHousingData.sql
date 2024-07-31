

--CLEANING DATA

SELECT *
FROM HousingData..NashvilleHousingData

--STANDARDIZE DATE FORMAT
SELECT SaleDateConverted, CONVERT(Date, SaleDate)
FROM HousingData..NashvilleHousingData 

UPDATE NashvilleHousingData
SET SaleDate = CONVERT(Date, SaleDate)


ALTER TABLE NashvilleHousingData
ADD SaleDateConverted Date

UPDATE NashvilleHousingData
SET SaleDateConverted = CONVERT(Date, SaleDate)


--PROPERTY ADDRESS
SELECT *
FROM HousingData..NashvilleHousingData
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID


SELECT X.ParcelID, X.PropertyAddress, Y.ParcelID, Y.PropertyAddress, ISNULL(X.PropertyAddress, Y.PropertyAddress)
FROM HousingData..NashvilleHousingData X
JOIN HousingData..NashvilleHousingData Y
ON X.ParcelID = Y.ParcelID
AND X.[UniqueID ] != Y.[UniqueID ]
WHERE X.PropertyAddress IS NULL


UPDATE X
SET PropertyAddress = ISNULL(X.PropertyAddress, Y.PropertyAddress)
FROM HousingData..NashvilleHousingData X
JOIN HousingData..NashvilleHousingData Y
ON X.ParcelID = Y.ParcelID
AND X.[UniqueID ] != Y.[UniqueID ]
WHERE X.PropertyAddress IS NULL



--BREAKING OUT ADDRESS INTO COLUMNS (ADDRESS, CITY, STATE)


SELECT PropertyAddress
FROM HousingData..NashvilleHousingData
--WHERE PropertyAddress IS NULL
--ORDER BY ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) Address
FROM HousingData..NashvilleHousingData


ALTER TABLE NashvilleHousingData
ADD PropertySplitAddress NVARCHAR(255)

UPDATE NashvilleHousingData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) 


ALTER TABLE NashvilleHousingData
ADD PropertySplitCity NVARCHAR(255)

UPDATE NashvilleHousingData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))


SELECT OwnerAddress
FROM HousingData..NashvilleHousingData


SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM HousingData..NashvilleHousingData


ALTER TABLE NashvilleHousingData
ADD OwnerSplitAddress NVARCHAR(255)

UPDATE NashvilleHousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE NashvilleHousingData
ADD OwnerSplitCity NVARCHAR(255)

UPDATE NashvilleHousingData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousingData
ADD OwnerSplitState NVARCHAR(255)

UPDATE NashvilleHousingData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

SELECT *
FROM HousingData..NashvilleHousingData


--CHANGING Y AND N TO YES AND NO


SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM HousingData..NashvilleHousingData
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
	END 
FROM HousingData..NashvilleHousingData


UPDATE NashvilleHousingData
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
	END 


--REMOVING DUPLICATES

WITH RowNumCTE AS (
SELECT *,
ROW_NUMBER() OVER (
			PARTITION BY ParcelID,
						 PropertyAddress,
						 SalePrice,
						 SaleDate,
						 LegalReference
						 ORDER BY UniqueID) row_num
FROM HousingData..NashvilleHousingData)
--ORDER BY ParcelID

SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress


--DELETING UNUSED COLUMN

SELECT *
FROM HousingData.dbo.NashvilleHousingData

ALTER TABLE HousingData.dbo.NashvilleHousingData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate