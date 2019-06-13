/*
	Retorna o historico dos transportes de todos os containers especificando
    em que veiculo foi transportado em que periodo de tempo.
    
	Formato: (idContainer_PK, idVeiculo_PK, tipoVeiculo,
									dataInicio, dataFim)
*/

SELECT t.idContainer_PK, v.idVeiculo_PK, v.tipoVeiculo, t.dataInicio, t.dataFim
FROM (SELECT *
FROM Container c INNER JOIN Transporta_Transporte t
ON c.idContainer_PK = t.idContainer_SPK
ORDER BY c.idContainer_PK) t INNER JOIN Veiculo v
ON t.idVeiculo_SPK = v.idVeiculo_PK
ORDER BY t.idContainer_PK;
