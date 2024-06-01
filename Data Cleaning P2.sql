DELETE 
FROM layoff_duplicate3
WHERE r_n > 1;
;

SELECT * 
from layoff_duplicate3
WHERE industry LIKE '%Crypto%'
;

UPDATE layoff_duplicate3
SET company = trim(company);


UPDATE layoff_duplicate3
SET industry = 'Crypto'
WHERE industry like '%crypto%'
;

UPDATE layoff_duplicate3
SET country = 'United States'
WHERE country = '%United States%'
;

SELECT `date`
FROM layoff_duplicate3;

UPDATE layoff_duplicate3
SET date = STR_TO_DATE(`date`, '%d%m%Y');
