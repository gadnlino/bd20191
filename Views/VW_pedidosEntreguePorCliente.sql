/*Descrição: mostra todos os pedidos que foram entregues, mostrados de acordo com cada cliente*/

/*DROP VIEW VW_pedidosEntreguePorCliente*/
CREATE VIEW VW_pedidosEntreguePorCliente AS select c.idCliente_PK, p.idPedido_PK, p.dataSolicitacao,
         p.dataEntrega,p.statusPedido from Cliente c inner join Pedido p on p.idCliente_FK = c.idCliente_PK
             where p.statusPedido = 'Entregue' order by c.idCliente_PK;