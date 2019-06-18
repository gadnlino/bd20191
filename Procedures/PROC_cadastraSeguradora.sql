/*PROCEDURE PROC_insereSeguradora*/
/*Função; cadastrar uma nova seguradora no registro*/

DROP PROCEDURE IF EXISTS PROC_insereSeguradora;
DELIMITER $$
CREATE PROCEDURE PROC_insereSeguradora(email VARCHAR(60), cnpj VARCHAR(14), razaoSocial VARCHAR(60), nome VARCHAR(60), telefone VARCHAR(11))
BEGIN
    DECLARE maxId INT unsigned DEFAULT 1;
    SELECT MAX(idSeguradora_PK) INTO maxId FROM Seguradora;
    insert into Seguradora (idseguradora_pk, emailseguradora, cnpj, razaosocial,
                	nome, telefone) 
    					VALUES(maxId+1, email, cnpj, razaoSocial, nome, telefone);
END $$
DELIMITER ;