SELECT * 
FROM layoff_duplicate3
;

UPDATE layoff_duplicate3
SET date = STR_TO_DATE(`date`, '%y-%d-%m');

ALTER table layoff_duplicate3
MODIFY COLUMN `date` DATE ;

SELECT  sum(total_laid_off) , YEAR(date)
FROM layoff_duplicate3
group by YEAR(date)
order by 2 desc;

SELECT MIN(date) , max(date)
from layoff_duplicate3;

SELECT SUBSTRING(date , 6,2) AS MONTHS
FROM layoff_duplicate3;

SELECT SUBSTRING(date, 1,7) AS 'MONTHS' , sum(total_laid_off)
FROM layoff_duplicate3
WHERE SUBSTRING(date, 1,7) IS NOT NULL 
group by SUBSTRING(date, 1,7)
order by 1 ASC ;

WITH Rolling_total AS 
(
SELECT SUBSTRING(date, 1,7) AS MONTHS , sum(total_laid_off) AS total_off
FROM layoff_duplicate3
WHERE SUBSTRING(date, 1,7) IS NOT NULL 
group by SUBSTRING(date, 1,7)
order by 1 ASC 
)
SELECT MONTHS , total_off , SUM(total_off) OVER(ORDER BY MONTHS) AS rolling_total
FROM Rolling_total
;

WITH Company_rankings (company , years , total_laid_off) AS 
(
SELECT company , YEAR(date) , SUM(total_laid_off)
FROM layoff_duplicate3
GROUP BY company , YEAR(date)
)
SELECT * , dense_rank() OVER (partition by years ORDER BY total_laid_off DESC) AS RANKS
FROM company_rankings
WHERE years IS NOT NULL
ORDER BY RANKS ASC;
