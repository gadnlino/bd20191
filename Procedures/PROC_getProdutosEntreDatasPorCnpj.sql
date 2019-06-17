/*PROCEDURE PROC_cadastraSeguradora*/
/*Função: buscar produtos de um cliente,identificado por cnpj, cujo pedido foi 
    solicitado entre um periodo de tempo*/

DROP PROCEDURE IF EXISTS PROC_getProdutosEntreDatasPorCnpj;
DELIMITER $$
CREATE PROCEDURE PROC_getProdutosEntreDatasPorCnpj(cnpj VARCHAR(14), dataInicio DATE, dataFim DATE)
BEGIN
    select res.nome, res.idPedido_PK, res.idProduto_PK, res.dataSolicitacao from (select * from 
        Pedido pe,Produto pr,(select cl.idCliente_PK,cl.nome from Cliente cl, PessoaJuridica pj where 
            pf.cnpj = cnpj and pj.idCliente_SPK = cl.idCliente_PK) pf2 where pe.idPedido_PK = pr.idPedido_FK 
                and pe.dataSolicitacao BETWEEN dataInicio and dataFim and pf2.idCliente_PK = pe.idCliente_FK)
                    res order by res.idPedido_FK;
END $$
DELIMITER ;