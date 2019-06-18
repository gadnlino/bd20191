/*PROCEDURE PROC_insereCliente*/
/*Função; cadastrar uma novo cliente no registro*/

DROP PROCEDURE IF EXISTS PROC_insereCliente;
DELIMITER $$
CREATE PROCEDURE PROC_insereCliente(cpf VARCHAR(11),rg VARCHAR(9), cnpj VARCHAR(9), razaoSocial VARCHAR(50), cep VARCHAR(8), emailCliente VARCHAR(60),nome VARCHAR(30), endereco VARCHAR(30), telefone VARCHAR(11))
BEGIN
	DECLARE maxId INT DEFAULT 0;
    SELECT MAX(idCliente_PK) INTO maxId FROM Cliente;
    INSERT INTO Cliente(idcliente_pk, cep, emailCliente, nome, endereco, telefone) VALUES (maxId+1, cep, emailCliente, nome, endereco, telefone);
    
    IF cnpj = NULL
            THEN INSERT INTO PessoaFisica(cpf, rg, idcliente_spk) VALUES (cpf,rg,maxId+1);
    ELSE INSERT INTO PessoaJuridica(cnpj, razaosocial, idcliente_spk) VALUES (cnpj,razaoSocial,maxId+1);
    END IF;
    
END$$
DELIMITER ;