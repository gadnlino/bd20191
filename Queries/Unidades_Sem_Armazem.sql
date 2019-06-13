/*
	ID de todas as unidades que não tem armazem
*/

SELECT 
    u.idUnidade_PK
FROM
    Unidade u
        LEFT JOIN
    Armazem a ON u.idUnidade_PK = a.idUnidade_FK
WHERE
    a.idUnidade_FK IS NULL;
