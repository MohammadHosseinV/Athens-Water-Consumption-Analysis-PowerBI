
--Zero Area English
SELECT COUNT(*) AS ZeroAreaEnglish
FROM stg.WaterConsumption_Translation_2021_2022
WHERE AreaEnglish = '0';

SELECT COUNT(*) AS ZeroAreaEnglish
FROM stg.WaterConsumption_Translation_2023_2025
WHERE AreaEnglish = '0';



--Zero Area Greek
SELECT COUNT(*) AS ZeroAreaGreek
FROM stg.WaterConsumption_Translation_2021_2022
WHERE AreaGreek = '0';

SELECT COUNT(*) AS ZeroAreaGreek
FROM stg.WaterConsumption_Translation_2023_2025
WHERE AreaGreek = '0';



--Update Area English

UPDATE stg.WaterConsumption_Translation_2021_2022
SET AreaEnglish = NULL
WHERE AreaEnglish = '0';


UPDATE stg.WaterConsumption_Translation_2023_2025
SET AreaEnglish = NULL
WHERE AreaEnglish = '0';


--Update Area Greek

UPDATE stg.WaterConsumption_Translation_2021_2022
SET AreaGreek = NULL
WHERE AreaGreek = '0';


UPDATE stg.WaterConsumption_Translation_2023_2025
SET AreaGreek = NULL
WHERE AreaGreek = '0';


--Test AreaEnglish
SELECT COUNT(*) AS RemainingZeroAreaEnglish
FROM stg.WaterConsumption_Translation_2021_2022
WHERE AreaEnglish = '0';

SELECT COUNT(*) AS RemainingZeroAreaEnglish
FROM stg.WaterConsumption_Translation_2023_2025
WHERE AreaEnglish = '0';

--Test AreaGreek
SELECT COUNT(*) AS RemainingZeroAreaGreek
FROM stg.WaterConsumption_Translation_2021_2022
WHERE AreaGreek = '0';

SELECT COUNT(*) AS RemainingZeroAreaGreek
FROM stg.WaterConsumption_Translation_2023_2025
WHERE AreaGreek = '0';