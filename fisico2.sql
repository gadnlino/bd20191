
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema remote_mysql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `remote_mysql` ;
USE `remote_mysql` ;

-- -----------------------------------------------------
-- Table `remote_mysql`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Cliente` (
  `idCliente_PK` INT NULL DEFAULT NULL,
  `cep` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(20) NULL DEFAULT NULL,
  `nome` VARCHAR(20) NULL DEFAULT NULL,
  `endereco` VARCHAR(20) NULL DEFAULT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`PessoaFisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`PessoaFisica` (
  `cpf` VARCHAR(20) NULL DEFAULT NULL,
  `rg` VARCHAR(20) NULL DEFAULT NULL,
  `idCliente_SPK` INT NULL DEFAULT NULL,
  INDEX `fk_{0240E7CD-01C5-4F51-888A-0FF779A03DBE}` (`idCliente_SPK` ASC),
  CONSTRAINT `fk_{0240E7CD-01C5-4F51-888A-0FF779A03DBE}`
    FOREIGN KEY (`idCliente_SPK`)
    REFERENCES `remote_mysql`.`Cliente` (`idCliente_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`PessoaJuridica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`PessoaJuridica` (
  `cnpj` VARCHAR(20) NULL DEFAULT NULL,
  `razaoSocial` VARCHAR(20) NULL DEFAULT NULL,
  `idCliente_SPK` INT NULL DEFAULT NULL,
  INDEX `fk_{A7E932B4-D7CD-42FA-B1D4-B62C842D3E30}` (`idCliente_SPK` ASC),
  CONSTRAINT `fk_{A7E932B4-D7CD-42FA-B1D4-B62C842D3E30}`
    FOREIGN KEY (`idCliente_SPK`)
    REFERENCES `remote_mysql`.`Cliente` (`idCliente_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Unidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Unidade` (
  `email` VARCHAR(20) NULL DEFAULT NULL,
  `endereco` VARCHAR(20) NULL DEFAULT NULL,
  `idUnidade_PK` INT NOT NULL,
  `cep` VARCHAR(8) NULL DEFAULT NULL,
  `telefone` VARCHAR(11) NULL DEFAULT NULL,
  `dataFim` DATE NULL DEFAULT NULL,
  `dataInicio` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idUnidade_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Armazem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Armazem` (
  `largura` FLOAT NULL DEFAULT NULL,
  `altura` FLOAT NULL DEFAULT NULL,
  `idArmazem_PK` INT NOT NULL,
  `numMaxContainers` INT NULL DEFAULT NULL,
  `comprimento` FLOAT NULL DEFAULT NULL,
  `lotacaoAtual` VARCHAR(20) NULL DEFAULT NULL,
  `idUnidade_FK` INT NOT NULL,
  PRIMARY KEY (`idArmazem_PK`),
  INDEX `fk_{294140E4-A95E-4F45-9D78-0C68B21F1BF4}` (`idUnidade_FK` ASC),
  CONSTRAINT `fk_{294140E4-A95E-4F45-9D78-0C68B21F1BF4}`
    FOREIGN KEY (`idUnidade_FK`)
    REFERENCES `remote_mysql`.`Unidade` (`idUnidade_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Seguradora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Seguradora` (
  `idSeguradora_PK` INT NOT NULL,
  `email` VARCHAR(20) NULL,
  `cnpj` VARCHAR(20) NULL,
  `razaoSocial` VARCHAR(20) NULL DEFAULT NULL,
  `nome` VARCHAR(20) NULL DEFAULT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idSeguradora_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Pedido` (
  `idPedido_PK` INT NULL DEFAULT NULL,
  `dataEntrega` VARCHAR(20) NULL DEFAULT NULL,
  `dataSolicitacao` VARCHAR(20) NULL DEFAULT NULL,
  `destino` VARCHAR(20) NULL DEFAULT NULL,
  `status` VARCHAR(20) NULL DEFAULT NULL,
  `destinatario` VARCHAR(20) NULL DEFAULT NULL,
  `idCliente_FK` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idPedido_PK`),
  INDEX `fk_{D4B96C22-5243-4211-A675-914B1C7743BA}` (`idCliente_FK` ASC),
  CONSTRAINT `fk_{D4B96C22-5243-4211-A675-914B1C7743BA}`
    FOREIGN KEY (`idCliente_FK`)
    REFERENCES `remote_mysql`.`Cliente` (`idCliente_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Acidente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Acidente` (
  `idAcidente_PK` INT NULL DEFAULT NULL,
  `descricao` VARCHAR(20) NULL DEFAULT NULL,
  `data` DATE NULL DEFAULT NULL,
  `id_seguradora_fk` INT NULL,
  `id_pedido_FK` INT NULL,
  PRIMARY KEY (`idAcidente_PK`),
  INDEX `idSeguradora_idx` (`id_seguradora_fk` ASC),
  INDEX `id_pedido_FK_idx` (`id_pedido_FK` ASC),
  CONSTRAINT `id_seguradora_FK`
    FOREIGN KEY (`id_seguradora_fk`)
    REFERENCES `remote_mysql`.`Seguradora` (`idSeguradora_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_pedido_FK`
    FOREIGN KEY (`id_pedido_FK`)
    REFERENCES `remote_mysql`.`Pedido` (`idPedido_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `remote_mysql`.`Rota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Rota` (
  `idUnidadeOrigem_SPK` INT NULL DEFAULT NULL,
  `idUnidadeDestino_SPK` INT NULL DEFAULT NULL,
  INDEX `fk_{7E832E7A-D6C4-4388-98EC-EC30887EB372}` (`idUnidadeOrigem_SPK` ASC),
  INDEX `fk_{19EB73A9-3D0A-4814-B644-E6ED28CA9A77}` (`idUnidadeDestino_SPK` ASC),
  CONSTRAINT `fk_{7E832E7A-D6C4-4388-98EC-EC30887EB372}`
    FOREIGN KEY (`idUnidadeOrigem_SPK`)
    REFERENCES `remote_mysql`.`Unidade` (`idUnidade_PK`),
  CONSTRAINT `fk_{19EB73A9-3D0A-4814-B644-E6ED28CA9A77}`
    FOREIGN KEY (`idUnidadeDestino_SPK`)
    REFERENCES `remote_mysql`.`Unidade` (`idUnidade_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Funcionario` (
  `email` VARCHAR(30) NULL DEFAULT NULL,
  `dataContratacao` DATE NULL DEFAULT NULL,
  `salario` FLOAT NULL DEFAULT NULL,
  `endereco` VARCHAR(30) NULL DEFAULT NULL,
  `matricula` VARCHAR(20) NULL DEFAULT NULL,
  `rg` VARCHAR(20) NULL DEFAULT NULL,
  `idFuncionario_PK` INT NOT NULL,
  `telefone` VARCHAR(11) NULL DEFAULT NULL,
  `dataNascimento` DATE NULL DEFAULT NULL,
  `departamento` VARCHAR(20) NULL DEFAULT NULL,
  `idUnidade_FK` INT NULL DEFAULT NULL,
  UNIQUE INDEX (`matricula` ASC),
  UNIQUE INDEX (`rg` ASC),
  PRIMARY KEY (`idFuncionario_PK`),
  INDEX `fk_{F44E23A9-8A3E-4FE6-ABCA-99236CF66C59}` (`idUnidade_FK` ASC),
  CONSTRAINT `fk_{F44E23A9-8A3E-4FE6-ABCA-99236CF66C59}`
    FOREIGN KEY (`idUnidade_FK`)
    REFERENCES `remote_mysql`.`Unidade` (`idUnidade_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Lote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Lote` (
  `idLote_PK` INT NOT NULL,
  `setor` VARCHAR(20) NULL DEFAULT NULL,
  `posicao` VARCHAR(20) NULL DEFAULT NULL,
  `idArmazem_FK` INT NOT NULL,
  PRIMARY KEY (`idLote_PK`),
  INDEX `fk_{B2B5AE49-CFD7-491A-99FD-8177C174A27A}` (`idArmazem_FK` ASC),
  CONSTRAINT `fk_{B2B5AE49-CFD7-491A-99FD-8177C174A27A}`
    FOREIGN KEY (`idArmazem_FK`)
    REFERENCES `remote_mysql`.`Armazem` (`idArmazem_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Veiculo` (
  `idVeiculo_PK` INT NULL DEFAULT NULL,
  `numMaxContainers` INT NULL DEFAULT NULL,
  `localizacao` VARCHAR(30) NULL DEFAULT NULL,
  `fabricante` VARCHAR(30) NULL DEFAULT NULL,
  `capacidadeCombustivel` DOUBLE NULL DEFAULT NULL,
  `cargaMaxima` DOUBLE NULL DEFAULT NULL,
  `statusVeiculo` VARCHAR(20) NULL DEFAULT NULL,
  `unidadeOrigem_FK` INT NULL DEFAULT NULL,
  `tempoUtilizacao` INT NULL DEFAULT NULL,
  `lotacaoAtual` INT NULL DEFAULT NULL,
  `disponibilidade`  NULL DEFAULT NULL,
  `tipo` ENUM('Trem', 'Navio', 'Caminhão') NULL DEFAULT NULL,
  PRIMARY KEY (`idVeiculo_PK`),
  INDEX `fk_{2101E188-9AC8-4ADB-BC23-40B8F02EA90D}` (`unidadeOrigem_FK` ASC),
  CONSTRAINT `fk_{2101E188-9AC8-4ADB-BC23-40B8F02EA90D}`
    FOREIGN KEY (`unidadeOrigem_FK`)
    REFERENCES `remote_mysql`.`Unidade` (`idUnidade_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Caminhao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Caminhao` (
  `idVeiculo_SPK` INT NOT NULL,
  PRIMARY KEY (`idVeiculo_SPK`),
  CONSTRAINT `fk_{2E972097-8516-42AC-90A6-7C5450339D76}`
    FOREIGN KEY (`idVeiculo_SPK`)
    REFERENCES `remote_mysql`.`Veiculo` (`idVeiculo_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Navio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Navio` (
  `idVeiculo_SPK` INT NOT NULL,
  PRIMARY KEY (`idVeiculo_SPK`),
  CONSTRAINT `fk_{B9E7793A-C181-4767-97D2-68736668CBDD}`
    FOREIGN KEY (`idVeiculo_SPK`)
    REFERENCES `remote_mysql`.`Veiculo` (`idVeiculo_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Trem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Trem` (
  `idVeiculo_SPK` INT NULL DEFAULT NULL,
  INDEX `fk_{E2CEA0C4-CAD4-4E5E-9CD6-2342F575A657}` (`idVeiculo_SPK` ASC),
  CONSTRAINT `fk_{E2CEA0C4-CAD4-4E5E-9CD6-2342F575A657}`
    FOREIGN KEY (`idVeiculo_SPK`)
    REFERENCES `remote_mysql`.`Veiculo` (`idVeiculo_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Container`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Container` (
  `idContainer_PK` INT NULL DEFAULT NULL,
  `dataAquisicao` VARCHAR(20) NULL DEFAULT NULL,
  `comprimento` VARCHAR(20) NULL DEFAULT NULL,
  `capacidade` VARCHAR(20) NULL DEFAULT NULL,
  `statusContainer` VARCHAR(20) NULL DEFAULT NULL,
  `vidaUtil` VARCHAR(20) NULL DEFAULT NULL,
  `largura` VARCHAR(20) NULL DEFAULT NULL,
  `lotacaoAtual` VARCHAR(20) NULL DEFAULT NULL,
  `disponibilidade` VARCHAR(20) NULL DEFAULT NULL,
  `altura` VARCHAR(20) NULL DEFAULT NULL,
  `idLote_FK` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idContainer_PK`),
  INDEX `fk_{CA531CD4-9C47-428C-826F-A1AEA51B2535}` (`idLote_FK` ASC),
  CONSTRAINT `fk_{CA531CD4-9C47-428C-826F-A1AEA51B2535}`
    FOREIGN KEY (`idLote_FK`)
    REFERENCES `remote_mysql`.`Lote` (`idLote_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Produto` (
  `idProduto_PK` INT NULL DEFAULT NULL,
  `comprimento` DOUBLE NULL DEFAULT NULL,
  `descricao` VARCHAR(20) NULL DEFAULT NULL,
  `peso` DOUBLE NULL DEFAULT NULL,
  `largura` DOUBLE NULL DEFAULT NULL,
  `altura` DOUBLE NULL DEFAULT NULL,
  `idPedido_FK` INT NULL,
  PRIMARY KEY (`idProduto_PK`),
  INDEX `fk_{CFEC6367-34E9-4A16-A2F0-1223CE141D52}` (`idPedido_FK` ASC),
  CONSTRAINT `fk_{CFEC6367-34E9-4A16-A2F0-1223CE141D52}`
    FOREIGN KEY (`idPedido_FK`)
    REFERENCES `remote_mysql`.`Pedido` (`idPedido_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Capitao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Capitao` (
  `ARRAIS` VARCHAR(20) NULL DEFAULT NULL,
  `idFuncionario_SPK` INT NOT NULL,
  UNIQUE INDEX (`ARRAIS` ASC),
  UNIQUE INDEX (`idFuncionario_SPK` ASC),
  PRIMARY KEY (`idFuncionario_SPK`),
  CONSTRAINT `fk_{B9CC0C79-25D8-4404-800F-81E5B339D256}`
    FOREIGN KEY (`idFuncionario_SPK`)
    REFERENCES `remote_mysql`.`Funcionario` (`idFuncionario_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Estoquista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Estoquista` (
  `idFuncionario_SPK` INT NULL DEFAULT NULL,
  INDEX `fk_{40883AA0-DE40-425C-87B3-FAB66B76B52A}` (`idFuncionario_SPK` ASC),
  CONSTRAINT `fk_{40883AA0-DE40-425C-87B3-FAB66B76B52A}`
    FOREIGN KEY (`idFuncionario_SPK`)
    REFERENCES `remote_mysql`.`Funcionario` (`idFuncionario_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Maquinista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Maquinista` (
  `autorizacao` VARCHAR(20) NULL DEFAULT NULL,
  `idFuncionario_SPK` INT NOT NULL,
  UNIQUE INDEX (`autorizacao` ASC),
  UNIQUE INDEX (`idFuncionario_SPK` ASC),
  PRIMARY KEY (`idFuncionario_SPK`),
  CONSTRAINT `fk_{24CBB1F4-D125-4448-B1B0-6C748533E844}`
    FOREIGN KEY (`idFuncionario_SPK`)
    REFERENCES `remote_mysql`.`Funcionario` (`idFuncionario_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Caminhoneiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Caminhoneiro` (
  `cnh` VARCHAR(11) NULL DEFAULT NULL,
  `idFuncionario_SPK` INT NOT NULL,
  UNIQUE INDEX (`cnh` ASC),
  UNIQUE INDEX (`idFuncionario_SPK` ASC),
  PRIMARY KEY (`idFuncionario_SPK`),
  CONSTRAINT `fk_{2E266BDA-7729-488D-B6E3-0FA74FED5ED0}`
    FOREIGN KEY (`idFuncionario_SPK`)
    REFERENCES `remote_mysql`.`Funcionario` (`idFuncionario_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Motorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Motorista` (
  `emViagem`  NULL DEFAULT NULL,
  `idFuncionario_SPK` INT NOT NULL,
  UNIQUE INDEX (`idFuncionario_SPK` ASC),
  PRIMARY KEY (`idFuncionario_SPK`),
  CONSTRAINT `fk_{BD2A86B7-B038-4907-B354-C60A2524121F}`
    FOREIGN KEY (`idFuncionario_SPK`)
    REFERENCES `remote_mysql`.`Funcionario` (`idFuncionario_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`TransportesDisponiveis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`TransportesDisponiveis` (
  `transportesDisponiveis_PK` INT NULL DEFAULT NULL,
  `transportesDisponiveis` VARCHAR(20) NULL DEFAULT NULL,
  `idUnidade_FK` INT NULL DEFAULT NULL,
  PRIMARY KEY (`transportesDisponiveis_PK`),
  INDEX `fk_{8ACB97FF-87EB-4C1D-84C2-533C4B275482}` (`idUnidade_FK` ASC),
  CONSTRAINT `fk_{8ACB97FF-87EB-4C1D-84C2-533C4B275482}`
    FOREIGN KEY (`idUnidade_FK`)
    REFERENCES `remote_mysql`.`Unidade` (`idUnidade_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`ProdutosSuportados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`ProdutosSuportados` (
  `produtosSuportados_PK` INT NULL DEFAULT NULL,
  `produtosSuportados` VARCHAR(20) NULL DEFAULT NULL,
  `idContainer_FK` INT NULL DEFAULT NULL,
  PRIMARY KEY (`produtosSuportados_PK`),
  INDEX `fk_{C8F45700-7B4E-4F5E-907C-FE83D0C03D30}` (`idContainer_FK` ASC),
  CONSTRAINT `fk_{C8F45700-7B4E-4F5E-907C-FE83D0C03D30}`
    FOREIGN KEY (`idContainer_FK`)
    REFERENCES `remote_mysql`.`Container` (`idContainer_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`TipoProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`TipoProduto` (
  `tipoProduto_PK` INT NULL DEFAULT NULL,
  `descricaoTipoProduto` VARCHAR(20) NULL DEFAULT NULL,
  `idProduto_FK` INT NULL DEFAULT NULL,
  PRIMARY KEY (`tipoProduto_PK`),
  INDEX `fk_{3FE759BB-13E4-4320-9D91-EBB6D940A82B}` (`idProduto_FK` ASC),
  CONSTRAINT `fk_{3FE759BB-13E4-4320-9D91-EBB6D940A82B}`
    FOREIGN KEY (`idProduto_FK`)
    REFERENCES `remote_mysql`.`Produto` (`idProduto_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Transporta_Transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Transporta_Transporte` (
  `idContainer_SPK` INT NULL DEFAULT NULL,
  `idVeiculo_SPK` INT NULL DEFAULT NULL,
  `dataDespacho` DATE NULL DEFAULT NULL,
  `dataChegada` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idContainer_SPK`, `idVeiculo_SPK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Cobre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Cobre` (
  `idPedido_SPK` INT NOT NULL,
  `idAcidente_SPK` INT NOT NULL,
  `idSeguradora_SPK` INT NOT NULL,
  PRIMARY KEY (`idPedido_SPK`, `idAcidente_SPK`, `idSeguradora_SPK`),
  INDEX `idAcidente_SPK_idx` (`idAcidente_SPK` ASC),
  INDEX `idSeguradora_SPK_idx` (`idSeguradora_SPK` ASC),
  CONSTRAINT `idPedido_SPK`
    FOREIGN KEY (`idPedido_SPK`)
    REFERENCES `remote_mysql`.`Pedido` (`idPedido_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idAcidente_SPK`
    FOREIGN KEY (`idAcidente_SPK`)
    REFERENCES `remote_mysql`.`Acidente` (`idAcidente_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idSeguradora_SPK`
    FOREIGN KEY (`idSeguradora_SPK`)
    REFERENCES `remote_mysql`.`Seguradora` (`idSeguradora_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `remote_mysql`.`Leva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Leva` (
  `dataInicio` DATE NOT NULL,
  `dataFim` DATE NOT NULL,
  `idVeiculo_FK` INT NULL,
  `idContainer_FK` INT NOT NULL,
  INDEX `fk_{38055C33-9857-44C6-BE40-E64276B512F0}` (`idVeiculo_FK` ASC),
  INDEX `fk_{2F885D12-3918-44AC-8603-6C811BDAAF5F}` (`idContainer_FK` ASC),
  CONSTRAINT `fk_{38055C33-9857-44C6-BE40-E64276B512F0}`
    FOREIGN KEY (`idVeiculo_FK`)
    REFERENCES `remote_mysql`.`Veiculo` (`idVeiculo_PK`),
  CONSTRAINT `fk_{2F885D12-3918-44AC-8603-6C811BDAAF5F}`
    FOREIGN KEY (`idContainer_FK`)
    REFERENCES `remote_mysql`.`Container` (`idContainer_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Despacha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Despacha` (
  `dataRecebimento` VARCHAR(20) NULL DEFAULT NULL,
  `dataDespacho` VARCHAR(20) NULL DEFAULT NULL,
  `idPedido_FK` INT NULL DEFAULT NULL,
  `idUnidade_FK` INT NULL DEFAULT NULL,
  INDEX `fk_{9D07D097-3815-41B6-9DF5-9C6513AFF44F}` (`idPedido_FK` ASC),
  INDEX `fk_{EFFC64B5-09B5-4A14-88AD-73779849A701}` (`idUnidade_FK` ASC),
  CONSTRAINT `fk_{9D07D097-3815-41B6-9DF5-9C6513AFF44F}`
    FOREIGN KEY (`idPedido_FK`)
    REFERENCES `remote_mysql`.`Pedido` (`idPedido_PK`),
  CONSTRAINT `fk_{EFFC64B5-09B5-4A14-88AD-73779849A701}`
    FOREIGN KEY (`idUnidade_FK`)
    REFERENCES `remote_mysql`.`Unidade` (`idUnidade_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Estoca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Estoca` (
  `dataEstoc` VARCHAR(20) NULL DEFAULT NULL,
  `idLote_SPK` INT NULL DEFAULT NULL,
  `idContainer_SPK` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idLote_SPK`, `idContainer_SPK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Contem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Contem` (
  `idProduto_FK` INT NULL DEFAULT NULL,
  `idContainer_FK` INT NULL DEFAULT NULL,
  INDEX `fk_{0E841945-2CA0-42DF-A9E6-9C67F14EA7AE}` (`idProduto_FK` ASC),
  INDEX `fk_{A8526743-A5F5-4B07-AA63-14CA2B1BA8D2}` (`idContainer_FK` ASC),
  CONSTRAINT `fk_{0E841945-2CA0-42DF-A9E6-9C67F14EA7AE}`
    FOREIGN KEY (`idProduto_FK`)
    REFERENCES `remote_mysql`.`Produto` (`idProduto_PK`),
  CONSTRAINT `fk_{A8526743-A5F5-4B07-AA63-14CA2B1BA8D2}`
    FOREIGN KEY (`idContainer_FK`)
    REFERENCES `remote_mysql`.`Container` (`idContainer_PK`));


-- -----------------------------------------------------
-- Table `remote_mysql`.`Conduz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `remote_mysql`.`Conduz` (
  `idVeiculo_FK` INT NULL DEFAULT NULL,
  INDEX `fk_{01FE8927-D638-4DE9-BC50-4FD2B977BC67}` (`idVeiculo_FK` ASC),
  CONSTRAINT `fk_{01FE8927-D638-4DE9-BC50-4FD2B977BC67}`
    FOREIGN KEY (`idVeiculo_FK`)
    REFERENCES `remote_mysql`.`Veiculo` (`idVeiculo_PK`));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
