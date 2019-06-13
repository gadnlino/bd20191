/*
	Retorna uma tabela com id_unidade em ordem e seus armazens relacionados.
*/
SELECT DISTINCT u.idUnidade_PK
FROM Unidade u INNER JOIN Armazem a
ON u.idUnidade_PK = a.idUnidade_FK
ORDER BY u.idUnidade_PK;