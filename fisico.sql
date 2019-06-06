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
DROP TABLE IF exists Seguradora;
DROP TABLE IF exists Acidente;
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
cpf VARCHAR(20),
rg VARCHAR(20),
idCliente_SPK INT
);

CREATE TABLE PessoaJuridica (
cnpj VARCHAR(20),
razaoSocial VARCHAR(20),
idCliente_SPK INT
);

CREATE TABLE Cliente (
idCliente_PK INT PRIMARY KEY,
cep VARCHAR(20),
email VARCHAR(20),
nome VARCHAR(20),
endereco VARCHAR(20),
telefone VARCHAR(20)
);

CREATE TABLE Armazem (
largura VARCHAR(20),
altura VARCHAR(20),
idArmazem_PK INT PRIMARY KEY,
numMaxContainers VARCHAR(20),
comprimento VARCHAR(20),
lotacaoAtual VARCHAR(20),
idUnidade_FK INT
);

CREATE TABLE Seguradora (
idSeguradora_PK INT PRIMARY KEY,
email VARCHAR(20),
cnpj VARCHAR(20),
razaoSocial VARCHAR(20),
nome VARCHAR(20),
telefone VARCHAR(20)
);

CREATE TABLE Acidente (
idAcidente_PK INT PRIMARY KEY,
descricao VARCHAR(20),
data VARCHAR(20)
);

CREATE TABLE Unidade (
email VARCHAR(20),
endereco VARCHAR(20),
idUnidade_PK INT PRIMARY KEY,
cep VARCHAR(20),
telefone VARCHAR(20),
dataFim VARCHAR(20),
dataInicio VARCHAR(20)
);

CREATE TABLE Pedido (
idPedido_PK INT PRIMARY KEY,
dataEntrega VARCHAR(20),
dataSolicitacao VARCHAR(20),
destino VARCHAR(20),
status VARCHAR(20),
destinatario VARCHAR(20),
idCliente_FK INT,
FOREIGN KEY(idCliente_FK) REFERENCES Cliente (idCliente_PK)
);

CREATE TABLE Rota (
idUnidadeOrigem_SPK INT,
idUnidadeDestino_SPK INT,
FOREIGN KEY(idUnidadeOrigem_SPK) REFERENCES Unidade (idUnidade_PK),
FOREIGN KEY(idUnidadeDestino_SPK) REFERENCES Unidade (idUnidade_PK)
);

CREATE TABLE Funcionario (
email VARCHAR(20),
dataContratacao VARCHAR(20),
salario VARCHAR(20),
endereco VARCHAR(20),
matricula VARCHAR(20),
rg VARCHAR(20),
idFuncionario_PK INT PRIMARY KEY,
telefone VARCHAR(20),
dataNascimento VARCHAR(20),
departamento VARCHAR(20),
idUnidade_FK INT,
FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK)
);

CREATE TABLE Lote (
idLote_PK INT PRIMARY KEY,
setor VARCHAR(20),
posicao VARCHAR(20),
idArmazem_FK INT,
FOREIGN KEY(idArmazem_FK) REFERENCES Armazem (idArmazem_PK)
);

CREATE TABLE Caminhao (
idVeiculo_SPK INT
);

CREATE TABLE Navio (
idVeiculo_SPK INT
);

CREATE TABLE Trem (
idVeiculo_SPK INT
);

CREATE TABLE Veiculo (
idVeiculo_PK INT PRIMARY KEY,
numMaxContainers INT,
localizacao VARCHAR(30),
fabricante VARCHAR(20),
capacidadeCombustivel DOUBLE,
cargaMaxima DOUBLE,
statusVeiculo VARCHAR(20),
unidadeOrigem_FK INT,
tempoUtilizacao INT,
lotacaoAtual INT,
disponibilidade BOOLEAN,
ehTrem BOOLEAN,
ehCaminhao BOOLEAN,
ehNavio BOOLEAN
);

CREATE TABLE Container (
idContainer_PK INT PRIMARY KEY,
dataAquisicao VARCHAR(20),
comprimento VARCHAR(20),
capacidade VARCHAR(20),
statusContainer VARCHAR(20),
vidaUtil VARCHAR(20),
largura VARCHAR(20),
lotacaoAtual VARCHAR(20),
disponibilidade VARCHAR(20),
altura VARCHAR(20),
idLote_FK INT,
FOREIGN KEY(idLote_FK) REFERENCES Lote (idLote_PK)
);

CREATE TABLE Produto (
idProduto_PK INT PRIMARY KEY,
comprimento DOUBLE,
descricao VARCHAR(20),
peso DOUBLE,
largura DOUBLE,
altura DOUBLE,
idPedido_FK INT,
FOREIGN KEY(idPedido_FK) REFERENCES Pedido (idPedido_PK)
);

CREATE TABLE Capitao (
ARRAIS VARCHAR(20)
);

CREATE TABLE Estoquista (
idFuncionario_SPK INT,
FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK)
);

CREATE TABLE Maquinista (
autorizacao VARCHAR(20)
);

CREATE TABLE Caminhoneiro (
cnh VARCHAR(20)
);

CREATE TABLE Motorista (
emViagem VARCHAR(20),
idFuncionario_SPK INT,
FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK)
);

CREATE TABLE TransportesDisponiveis (
transportesDisponiveis_PK INT PRIMARY KEY,
transportesDisponiveis VARCHAR(20),
idUnidade_FK INT,
FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK)
);

CREATE TABLE ProdutosSuportados (
produtosSuportados_PK INT PRIMARY KEY,
produtosSuportados VARCHAR(20),
idContainer_FK INT,
FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK)
);

CREATE TABLE TipoProduto (
tipoProduto_PK INT PRIMARY KEY,
descricaoTipoProduto VARCHAR(20),
idProduto_FK INT,
FOREIGN KEY(idProduto_FK) REFERENCES Produto (idProduto_PK)
);

CREATE TABLE Transporta_Transporte (
idContainer_SPK INT,
idVeiculo_SPK INT,
dataDespacho DATE,
dataChegada DATE,
PRIMARY KEY(idContainer_SPK,idVeiculo_SPK)
);

CREATE TABLE Cobre (
idPedido_SPK INT,
idAcidente_SPK INT,
idSeguradora_SPK INT,
PRIMARY KEY(idPedido_SPK,idAcidente_SPK,idSeguradora_SPK)
);

CREATE TABLE Leva (
dataInicio VARCHAR(20),
dataFim VARCHAR(20),
idVeiculo_FK INT,
idContainer_FK INT,
FOREIGN KEY(idVeiculo_FK) REFERENCES Veiculo (idVeiculo_PK),
FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK)
);

CREATE TABLE Despacha (
dataRecebimento VARCHAR(20),
dataDespacho VARCHAR(20),
idPedido_FK INT,
idUnidade_FK INT,
FOREIGN KEY(idPedido_FK) REFERENCES Pedido (idPedido_PK),
FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK)
);

CREATE TABLE Estoca (
dataEstoc VARCHAR(20),
idLote_SPK INT,
idContainer_SPK INT,
PRIMARY KEY(idLote_SPK,idContainer_SPK)
);

CREATE TABLE Contem (
idProduto_FK INT,
idContainer_FK INT,
FOREIGN KEY(idProduto_FK) REFERENCES Produto (idProduto_PK),
FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK)
);

CREATE TABLE Conduz (
idVeiculo_FK INT,
FOREIGN KEY(idVeiculo_FK) REFERENCES Veiculo (idVeiculo_PK)
);

ALTER TABLE PessoaFisica ADD FOREIGN KEY(idCliente_SPK) REFERENCES Cliente (idCliente_PK);
ALTER TABLE PessoaJuridica ADD FOREIGN KEY(idCliente_SPK) REFERENCES Cliente (idCliente_PK);
ALTER TABLE Armazem ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK);
ALTER TABLE Caminhao ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Navio ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Trem ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK);
ALTER TABLE Veiculo ADD FOREIGN KEY(unidadeOrigem_FK) REFERENCES Unidade(idUnidade_PK);
