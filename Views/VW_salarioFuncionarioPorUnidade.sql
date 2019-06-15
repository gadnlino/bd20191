/*Descrição: mostra o salario de cada funcionario, organizados por unidade*/

/*DROP VIEW VW_salarioFuncionarioPorUnidade*/
CREATE VIEW VW_salarioFuncionarioPorUnidade AS select u.idUnidade_PK, u.cep, f.emailFuncionario,
    f.salario from Unidade u right join Funcionario f on f.idUnidade_FK = u.idUnidade_PK 
        order by u.idUnidade_PK;