/*PROCEDURE PROC_inserePedido*/
/*Função; cadastrar uma novo pedido no registro*/

DROP PROCEDURE IF EXISTS PROC_inserePedido;
DELIMITER $$
CREATE PROCEDURE PROC_inserePedido(cpf VARCHAR(11),rg VARCHAR(9),cnpj VARCHAR(14), destinatario VARCHAR(30))
BEGIN
	DECLARE maxId INT DEFAULT 0;
    DECLARE idCli INT DEFAULT 0;

    SELECT MAX(idPedido_PK) INTO maxId FROM Pedido;
    
    IF cnpj = NULL THEN 
    	SELECT c.idCliente_PK INTO idCli FROM Cliente c,PessoaFisica pf WHERE pf.cpf = cpf AND pf.rg = rg AND c.idCliente_PK = pf.idCliente_SPK;  
        INSERT INTO Pedido (idpedido_pk, dataentrega, datasolicitacao, destino, statuspedido, destinatario, idcliente_fk)
    	    VALUES(maxId+1, NULL, CURDATE(), NULL, 'Não entregue', destinatario, idCli);
    ELSE
    	SELECT c.idCliente_PK INTO idCli FROM Cliente c, PessoaJuridica pj WHERE pj.cnpj = cnpj AND pj.idCliente_SPK = c.idCliente_PK;
        INSERT INTO Pedido (idpedido_pk, dataentrega, datasolicitacao, destino, statuspedido, destinatario, idcliente_fk)
    	    VALUES(maxId+1, NULL, CURDATE(), NULL, 'Não entregue', destinatario, idCli);
    END IF;
    
    /*INSERT INTO Pedido (idpedido_pk, dataentrega, datasolicitacao, destino, statuspedido, destinatario, idcliente_fk)
    	VALUES(maxId+1, NULL, CURDATE(), NULL, 'Não entregue', destinatario, idCli); */
END $$
DELIMITER ;
