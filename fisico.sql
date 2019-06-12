-- Geracao de Modelo fisico
-- Sql ANSI 2003 - brModelo.

USE remote_mysql;

DROP TABLE IF exists PessoaFisica;
DROP TABLE IF exists PessoaJuridica;
DROP TABLE IF exists TipoProduto;
DROP TABLE IF exists Contem;
DROP TABLE IF exists Despacha;
DROP TABLE IF exists Leva;
DROP TABLE IF exists Cobre;
DROP TABLE IF exists Produto;
DROP TABLE IF exists Acidente;
DROP TABLE IF exists Seguradora;
DROP TABLE IF exists Pedido;
DROP TABLE IF exists Cliente;
DROP TABLE IF exists Rota;
DROP TABLE IF exists Estoquista;
DROP TABLE IF exists Motorista;
DROP TABLE IF exists Maquinista;
DROP TABLE IF exists Capitao;
DROP TABLE IF exists Caminhoneiro;
DROP TABLE IF exists Funcionario;
DROP TABLE IF exists TransportesDisponiveis;
DROP TABLE IF exists ProdutosSuportados;
DROP TABLE IF exists Estoca;
DROP TABLE IF exists Container;
DROP TABLE IF exists Lote;
DROP TABLE IF exists Armazem;
DROP TABLE IF exists Caminhao;
DROP TABLE IF exists Navio;
DROP TABLE IF exists Trem;
DROP TABLE IF exists Conduz;
DROP TABLE IF exists Transporta_Transporte;
DROP TABLE IF exists Veiculo;
DROP TABLE IF exists Unidade;

CREATE TABLE PessoaFisica(
cpf VARCHAR(11) UNIQUE,
rg VARCHAR(9) UNIQUE,
idCliente_SPK INT
);

CREATE TABLE PessoaJuridica (
cnpj VARCHAR(14) UNIQUE,
razaoSocial VARCHAR(30),
idCliente_SPK INT
);

CREATE TABLE Cliente (
idCliente_PK INT PRIMARY KEY,
cep VARCHAR(8),
email VARCHAR(20),
nome VARCHAR(30),
endereco VARCHAR(30),
telefone VARCHAR(11)
);

CREATE TABLE Armazem (
largura FLOAT,
altura FLOAT,
idArmazem_PK INT PRIMARY KEY NOT NULL,
numMaxContainers INT,
CONSTRAINT CHK_numMaxContainers 
	CHECK(numMaxContainers >= 50 AND numMaxContainers <= 200),
comprimento FLOAT,
lotacaoAtual INT,
idUnidade_FK INT NOT NULL
);

CREATE TABLE Seguradora (
idSeguradora_PK INT PRIMARY KEY,
email VARCHAR(20),
cnpj VARCHAR(14) UNIQUE,
razaoSocial VARCHAR(30),
nome VARCHAR(30),
telefone VARCHAR(11)
);

CREATE TABLE Acidente (
idAcidente_PK INT PRIMARY KEY,
descricao VARCHAR(20),
data_acidente DATE,

/*CONSTRAINT CHK_data_acidente
	CHECK(data_acidente <= GETDATE()),*/

id_seguradora_FK INT,
id_pedido_FK INT
);

CREATE TABLE Unidade (
email VARCHAR(20),
endereco VARCHAR(30),
idUnidade_PK INT PRIMARY KEY NOT NULL,
cep VARCHAR(8),
telefone VARCHAR(11),
caminhaoDisponivel BOOLEAN,
navioDisponivel BOOLEAN,
tremDisponivel BOOLEAN
);

CREATE TABLE Pedido (
idPedido_PK INT PRIMARY KEY,
dataEntrega DATE,
dataSolicitacao DATE,
CONSTRAINT CHK_dataEntrega
	CHECK(dataSolicitacao <= dataEntrega),
destino VARCHAR(30),
statusPedido ENUM('Não entregue','Em rota','Entregue'),
destinatario VARCHAR(30),
idCliente_FK INT
);

CREATE TABLE Rota (
idUnidadeOrigem_SPK INT,
idUnidadeDestino_SPK INT
);

CREATE TABLE Funcionario (
email VARCHAR(20),
dataContratacao DATE,
salario float,
endereco VARCHAR(30),
matricula INT UNIQUE,
rg VARCHAR(9) UNIQUE,
idFuncionario_PK INT NOT NULL PRIMARY KEY,
telefone VARCHAR(11),
dataNascimento DATE,
CONSTRAINT CHK_dataContratacao
	CHECK(dataNascimento < dataContratacao),
departamento VARCHAR(20),
idUnidade_FK INT
);

CREATE TABLE Lote (
idLote_PK INT NOT NULL PRIMARY KEY,
setor INT,
posicao INT,
idArmazem_FK INT NOT NULL
);

CREATE TABLE Caminhao (
idVeiculo_SPK INT NOT NULL PRIMARY KEY
);

CREATE TABLE Navio (
idVeiculo_SPK INT NOT NULL PRIMARY KEY
);

CREATE TABLE Trem (
idVeiculo_SPK INT PRIMARY KEY
);

CREATE TABLE Veiculo (
idVeiculo_PK INT PRIMARY KEY,
numMaxContainers INT,
localizacao VARCHAR(30),
fabricante VARCHAR(20),
capacidadeCombustivel DOUBLE,
cargaMaxima DOUBLE,
statusVeiculo ENUM('Disponivel','Em uso','Em manutenção','Desmobilizado'),
unidadeOrigem_FK INT,
tempoUtilizacao INT,
lotacaoAtual INT,
disponibilidade BOOLEAN,
tipoVeiculo ENUM('Trem', 'Navio', 'Caminhão')
);

CREATE TABLE Container (
idContainer_PK INT PRIMARY KEY,
dataAquisicao DATE,
comprimento DOUBLE,
altura DOUBLE,
largura DOUBLE,
capacidade DOUBLE,

/* Os status em geral poderiam ser um ENUM, assim como na tabela Veiculo, tipoVeiculo é ENUM ('Trem', 'Navio', 'Caminhão').
	Assim teriamos uma padronizacao dos status possiveis. */
statusContainer ENUM('Em uso','Disponivel','Em manutenção', 'Desmobilizado'),
/* Vida util em meses */
vidaUtil INT,
lotacaoAtual INT,
idLote_FK INT/* O lote em que se encontra o container*/,
disponibilidade BOOLEAN
);

CREATE TABLE Produto (
idProduto_PK INT PRIMARY KEY,
comprimento DOUBLE,
descricao VARCHAR(30),
peso DOUBLE,
largura DOUBLE,
altura DOUBLE,
idPedido_FK INT
);

CREATE TABLE Capitao (
ARRAIS VARCHAR(10) UNIQUE,
idFuncionario_SPK INT NOT NULL PRIMARY KEY
);

CREATE TABLE Estoquista (
idFuncionario_SPK INT
);

CREATE TABLE Maquinista (
autorizacao VARCHAR(20),
idFuncionario_SPK INT UNIQUE NOT NULL PRIMARY KEY
);

CREATE TABLE Caminhoneiro (
cnh VARCHAR(11) UNIQUE,
idFuncionario_SPK INT UNIQUE NOT NULL PRIMARY KEY
);

CREATE TABLE Motorista (
emViagem BOOLEAN,
idFuncionario_SPK INT UNIQUE NOT NULL PRIMARY KEY
);

/*
Tabela deletada. E a informacao foi colocada como 3 BOOLEANos na
tabela Unidade.
Atributos adicionados na tabela unidade:

caminhaoDisponivel BOOLEAN
navioDisponivel BOOLEAN
tremDisponivel BOOLEAN

CREATE TABLE TransportesDisponiveis (
transportesDisponiveis_PK INT PRIMARY KEY,
transportesDisponiveis VARCHAR(20),
idUnidade_FK INT
);

*/

/*
	ProdutosSuportados pega guarda um PK para produto e uma descricao. Isso tudo é ligado a uma FK que referencia um container caso ele esteja alocado em um.
    Problema: Se o mesmo produto estiver alocado em mais de um container, não vamos conseguir guardar os dois já que a chave primaria é apenas ProdutosSuportados_PK.
		Se tentarmos mudar para uma chave primaria (produtosSuportados_PK, idContainer_FK) nao vamos poder ter um produto que não está alocado em nenhum container.
*/
CREATE TABLE ProdutosSuportados (
produtosSuportados_PK INT PRIMARY KEY,
produtosSuportados VARCHAR(20),
idContainer_FK INT,
descricaoProduto VARCHAR(30)
);

CREATE TABLE TipoProduto (
tipoProduto_PK INT PRIMARY KEY,
descricaoTipoProduto VARCHAR(20),
idProduto_FK INT
);

CREATE TABLE Transporta_Transporte (
idContainer_SPK INT,
idVeiculo_SPK INT,
dataDespacho DATE,
dataChegada DATE,
CONSTRAINT CHK_dataChegada
	CHECK(dataChegada < dataDespacho),
PRIMARY KEY(idContainer_SPK,idVeiculo_SPK)
);

CREATE TABLE Cobre (
idPedido_SPK INT,
idAcidente_SPK INT,
idSeguradora_SPK INT,
PRIMARY KEY(idPedido_SPK,idAcidente_SPK,idSeguradora_SPK)
);

CREATE TABLE Leva (
dataInicio DATE,
dataFim DATE,
idVeiculo_FK INT,
idContainer_FK INT
);

CREATE TABLE Despacha (
dataRecebimento DATE,
dataDespacho DATE,
CONSTRAINT CHK_dataRecebimento
	CHECK(dataRecebimento < dataDespacho),
idPedido_FK INT,
idUnidade_FK INT
);

CREATE TABLE Estoca (

/* Exemplo de TIMESTAMP (AAAA-MM-DD HH-MM-SS): '2002-09-27 09:12:47' */
dataEstoc DATETIME,
/*CONSTRAINT CHK_dataEstoc
	CHECK(dataEstoc <= GETDATE()),*/
idLote_SPK INT,
idContainer_SPK INT,
PRIMARY KEY(idLote_SPK,idContainer_SPK)
);

CREATE TABLE Contem (
idProduto_FK INT,
idContainer_FK INT
);

CREATE TABLE Conduz (
idVeiculo_FK INT
);

ALTER TABLE PessoaFisica ADD FOREIGN KEY(idCliente_SPK) REFERENCES Cliente (idCliente_PK);
ALTER TABLE PessoaJuridica ADD FOREIGN KEY(idCliente_SPK) REFERENCES Cliente (idCliente_PK);
ALTER TABLE Armazem ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK);
ALTER TABLE Caminhao ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Navio ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Trem ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Veiculo ADD FOREIGN KEY(unidadeOrigem_FK) REFERENCES Unidade(idUnidade_PK);
ALTER TABLE Cobre ADD FOREIGN KEY(idPedido_SPK) REFERENCES Pedido(idPedido_PK);
ALTER TABLE Cobre ADD FOREIGN KEY(idAcidente_SPK) REFERENCES Acidente(idAcidente_PK);
ALTER TABLE Cobre ADD FOREIGN KEY(idSeguradora_SPK) REFERENCES Seguradora(idSeguradora_PK);
ALTER TABLE Acidente ADD FOREIGN KEY (id_seguradora_FK) REFERENCES Seguradora(idSeguradora_PK);
ALTER TABLE Acidente ADD FOREIGN KEY (id_pedido_FK) REFERENCES Pedido(idPedido_PK);
ALTER TABLE Conduz ADD FOREIGN KEY(idVeiculo_FK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Pedido ADD FOREIGN KEY(idCliente_FK) REFERENCES Cliente (idCliente_PK);
ALTER TABLE Rota ADD FOREIGN KEY(idUnidadeOrigem_SPK) REFERENCES Unidade (idUnidade_PK);
ALTER TABLE Rota ADD FOREIGN KEY(idUnidadeDestino_SPK) REFERENCES Unidade (idUnidade_PK);
ALTER TABLE Funcionario ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK);
ALTER TABLE Lote ADD FOREIGN KEY(idArmazem_FK) REFERENCES Armazem (idArmazem_PK);
ALTER TABLE Container ADD FOREIGN KEY(idLote_FK) REFERENCES Lote (idLote_PK);
ALTER TABLE Produto ADD FOREIGN KEY(idPedido_FK) REFERENCES Pedido (idPedido_PK);
ALTER TABLE Capitao ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK);
ALTER TABLE Estoquista ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK);
ALTER TABLE Maquinista ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK);
ALTER TABLE Caminhoneiro ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK);
ALTER TABLE Motorista ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK);
/*ALTER TABLE TransportesDisponiveis ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK);*/
ALTER TABLE ProdutosSuportados ADD FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK);
ALTER TABLE TipoProduto ADD FOREIGN KEY(idProduto_FK) REFERENCES Produto (idProduto_PK);
ALTER TABLE Leva ADD FOREIGN KEY(idVeiculo_FK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Leva ADD FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK);
ALTER TABLE Despacha ADD FOREIGN KEY(idPedido_FK) REFERENCES Pedido (idPedido_PK);
ALTER TABLE Despacha ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK);
ALTER TABLE Contem ADD FOREIGN KEY(idProduto_FK) REFERENCES Produto (idProduto_PK);
ALTER TABLE Contem ADD FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK);