/*Descrição: mostra o salario de cada funcionario, organizados por unidade*/

DROP VIEW IF EXISTS VW_salarioFuncionarioPorUnidade;
CREATE VIEW VW_salarioFuncionarioPorUnidade AS select u.idUnidade_PK AS 'idUnidade',
    u.cep, f.matricula,f.salario from Unidade u right join Funcionario f on 
        f.idUnidade_FK = u.idUnidade_PK order by u.idUnidade_PK;