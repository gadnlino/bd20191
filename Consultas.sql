use remote_mysql;

-- Funcionários que também são clientes
select idFuncionario_PK, idCliente_PK
from Funcionario f, PessoaFisica p, Cliente c
where c.idCliente_PK = p.idCliente_SPK and f.RG = p.RG;
  
-- Buscar o nome das seguradoras que cobrem pedidos a partir de certa data de solicitação (ex: 01/11/2018)
select nome from Seguradora
where idSeguradora_PK in(select idSeguradora_SPK from Cobre c
						 where exists(select idPedido_PK from Pedido p
									  where p.dataSolicitacao > STR_TO_DATE('01/11/2018', '%d/%m/%Y') and c.idPedido_SPK = p.idPedido_PK));
                                      
-- Todos os funcionários de certa unidade que sejam estoquistas e motoristas que não estão em viagem 
select idFuncionario_PK from Funcionario
where idUnidade_FK = 1 and idFuncionario_PK in
(select idFuncionario_SPK from Estoquista
union
select idFuncionario_SPK from Motorista
where emViagem = false);

-- Salário total de cada departamento com valor maior que R$ 90000,00
select departamento, concat('R$ ', round(salarioTotal,2)) as salarioTotal
from (select departamento, sum(salario) as salarioTotal from Funcionario
	  group by departamento
	  having salarioTotal > 90000) as SalarioDepartamento;

-- Encontrar o nome dos destinatários de todos os produtos de um determinado conteiner (ex: idContainer = 5)
select destinatario from Pedido
where idPedido_PK in (select idPedido_FK from Produto
						where idProduto_PK in (select idProduto_FK from Contem
												where idContainer_Fk = 5));

-- ID dos produtos pertencentes à uma pessoa física (ex: cpf = )
select idProduto_PK from Produto
where idPedido_FK in (select idPedido_PK from Pedido 
						where idCliente_FK in (select idCliente_PK from Cliente
												where idCliente_PK in (select idCliente_FK from PessoaFisica
																		where cpf = 84684684156)));

-- ID dos produtos pertencentes à uma pessoa jurídica (ex: cnpj = )                                              
select idProduto_PK from Produto
where idPedido_FK in (select idPedido_PK from Pedido 
						where idCliente_FK in (select idCliente_PK from Cliente
												where idCliente_PK in (select idCliente_FK from PessoaJuridica
																		where cnpj = 84684684156)));      
			
-- Nome do cliente e seus pedidos afetados por um determinado acidente
select nome, idPedido_PK from Cliente c, Pedido p, Cobre co
where c.idCliente_PK = p.idCliente_FK and p.idPedido_PK = co.idPedido_SPK and co.idAcidente_SPK = 1;      

-- Produtos despachados por uma unidade em uma certa data (ex: dataDespacho = )
select idProduto_PK from Produto pr, Despacha d, Pedido p
where p.idPedido_PK = d.idPedido_FK and pr.idPedido_FK = p.idPedido_PK and d.idUnidade_FK = 1 and d.dataDespacho = STR_TO_DATE('26/09/2018', '%d/%m/%Y');

-- Estoquista que estocou determinado produto (ex: idProduto = 1)
select idFuncionario_SPK from Estoquista et, Estoca e, Container c, Contem ct
where et.idFuncionario_SPK = e.idEstoquista_SPK and ct.idContainer_FK = c.idContainer_PK and c.idContainer_PK = e.idContainer_SPK and ct.idProduto_FK = 1;
