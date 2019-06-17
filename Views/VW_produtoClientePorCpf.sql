/*Descrição: mostra todos os produtos de um cliente com um determinado cpf*/


DROP VIEW IF EXISTS VW_produtoClientePorCpf;
CREATE VIEW VW_produtoClientePorCpf as select pr.idProduto_PK AS 'idProduto', pr.descricao from 
    Produto pr inner join (select pe.idPedido_PK from Pedido pe inner join 
        (select c.idCliente_PK from Cliente c inner join PessoaFisica pf on 
            pf.idCliente_SPK = c.idCliente_PK where pf.cpf = 2665359904) cpfis 
                on cpfis.idCliente_PK = pe.idCliente_FK) ppfis on ppfis.idPedido_PK 
                    = pr.idPedido_FK;