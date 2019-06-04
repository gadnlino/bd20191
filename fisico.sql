-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

use remote_mysql;

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
DROP TABLE IF exists Unidade;
DROP TABLE IF exists Caminhao;
DROP TABLE IF exists Navio;
DROP TABLE IF exists Trem;
DROP TABLE IF exists Conduz;
DROP TABLE IF exists Veiculo;
DROP TABLE IF exists Transporta_Transporte;


CREATE TABLE PessoaFisica (
cpf VARCHAR(11) NOT NULL UNIQUE,
rg VARCHAR(9) NOT NULL UNIQUE,
idCliente INT PRIMARY KEY
);

CREATE TABLE PessoaJuridica (
cnpj VARCHAR(10),
razaoSocial VARCHAR(10),
idCliente INT PRIMARY KEY
);

CREATE TABLE Produto (
idProduto VARCHAR(10) PRIMARY KEY,
comprimento VARCHAR(10),
descrição VARCHAR(10),
peso VARCHAR(10),
largura VARCHAR(10),
altura VARCHAR(10),
idPedido VARCHAR(10)
);

CREATE TABLE Cliente (
idCliente INT PRIMARY KEY NOT NULL UNIQUE,
cep VARCHAR(10),
email VARCHAR(10),
telefone VARCHAR(10),
nome VARCHAR(10),
endereco VARCHAR(10)
);

CREATE TABLE Armazem (
largura VARCHAR(10),
altura VARCHAR(10),
idArmazem VARCHAR(10) PRIMARY KEY,
numMaxContainers VARCHAR(10),
comprimento VARCHAR(10),
lotacaoAtual VARCHAR(10),
idUnidade VARCHAR(10)
);

CREATE TABLE Seguradora (
idSeguradora VARCHAR(10) PRIMARY KEY,
telefone VARCHAR(10),
email VARCHAR(10),
cnpj VARCHAR(10),
razaoSocial VARCHAR(10),
nome VARCHAR(10)
);

CREATE TABLE Acidente (
idAcidente VARCHAR(10) PRIMARY KEY,
descricao VARCHAR(10),
data VARCHAR(10)
);

CREATE TABLE Unidade (
email VARCHAR(10),
endereco VARCHAR(10),
telefone VARCHAR(10),
cep VARCHAR(10),
idUnidade VARCHAR(10) PRIMARY KEY,
dataFim VARCHAR(10),
dataInicio VARCHAR(10)
);

CREATE TABLE Pedido (
idPedido VARCHAR(10) PRIMARY KEY,
dataEntrega VARCHAR(10),
dataSolicitacao VARCHAR(10),
destino VARCHAR(10),
status VARCHAR(10),
destinatário VARCHAR(10),
idCliente INT
);

CREATE TABLE Rota (
idUnidade VARCHAR(10),
FOREIGN KEY(idUnidade) REFERENCES Unidade (idUnidade)
);

CREATE TABLE Funcionario (
email VARCHAR(10),
dataContratacao VARCHAR(10),
salario VARCHAR(10),
endereco VARCHAR(10),
matricula VARCHAR(10),
rg VARCHAR(10),
idFuncionario VARCHAR(10) PRIMARY KEY,
telefone VARCHAR(10),
dataNascimento VARCHAR(10),
departamento VARCHAR(10),
idUnidade VARCHAR(10),
FOREIGN KEY(idUnidade) REFERENCES Unidade (idUnidade)
);

CREATE TABLE Veiculo (
idVeículo VARCHAR(10) PRIMARY KEY,
numMaxContainers VARCHAR(10),
localizacao VARCHAR(10),
fabricante VARCHAR(10),
capacidadeCombustivel VARCHAR(10),
cargaMaxima VARCHAR(10),
status VARCHAR(10),
unidadeOrigem VARCHAR(10),
tempoUtilizacao VARCHAR(10),
lotacaoAtual VARCHAR(10),
disponibilidade VARCHAR(10)
);

CREATE TABLE Estoquista (
idFuncionario VARCHAR(10),
FOREIGN KEY(idFuncionario) REFERENCES Funcionario (idFuncionario)
);

CREATE TABLE Lote (
idLote VARCHAR(10) PRIMARY KEY,
setor VARCHAR(10),
posicao VARCHAR(10),
idArmazem VARCHAR(10),
FOREIGN KEY(idArmazem) REFERENCES Armazem (idArmazem)
);

CREATE TABLE Container (
idContainer VARCHAR(10) PRIMARY KEY,
dataAquisicao VARCHAR(10),
comprimento VARCHAR(10),
capacidade VARCHAR(10),
status VARCHAR(10),
vidaUtil VARCHAR(10),
largura VARCHAR(10),
lotacaoAtual VARCHAR(10),
disponibilidade VARCHAR(10),
altura VARCHAR(10),
idLote VARCHAR(10),
FOREIGN KEY(idLote) REFERENCES Lote (idLote)
);

CREATE TABLE Motorista (
emViagem VARCHAR(10),
idFuncionario VARCHAR(10) PRIMARY KEY,
FOREIGN KEY(idFuncionario) REFERENCES Funcionario (idFuncionario)
);

CREATE TABLE Caminhao (
idVeículo VARCHAR(10) PRIMARY KEY,
FOREIGN KEY(idVeículo) REFERENCES Veiculo (idVeículo)
);

CREATE TABLE Navio (
idVeículo VARCHAR(10),
FOREIGN KEY(idVeículo) REFERENCES Veiculo (idVeículo)
);

CREATE TABLE Trem (
idVeículo VARCHAR(10),
FOREIGN KEY(idVeículo) REFERENCES Veiculo (idVeículo)
);

CREATE TABLE Maquinista (
autorizacao VARCHAR(10)
);

CREATE TABLE Capitao (
ARRAIS VARCHAR(10)
);

CREATE TABLE Caminhoneiro (
CNH VARCHAR(10)
);


CREATE TABLE TipoProduto (
tipoProduto_PK INTEGER PRIMARY KEY,
tipoProduto VARCHAR(10),
idProduto_FK VARCHAR(10),
FOREIGN KEY(idProduto_FK) REFERENCES Produto (idProduto)
);


CREATE TABLE TransportesDisponiveis (
transportesDisponiveis_PK INTEGER PRIMARY KEY,
transportesDisponiveis VARCHAR(10),
idUnidade_FK VARCHAR(10),
FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade)
);


CREATE TABLE ProdutosSuportados (
produtosSuportados_PK INTEGER PRIMARY KEY,
produtosSuportados VARCHAR(10),
idContainer_FK VARCHAR(10),
FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer)
);

CREATE TABLE Transporta_Transporte (
idContainer VARCHAR(10),
idVeículo VARCHAR(10),
dataDespacho VARCHAR(10),
dataChegada VARCHAR(10),
PRIMARY KEY(idContainer,idVeículo)
);

CREATE TABLE Cobre (
idPedido VARCHAR(10),
idAcidente VARCHAR(10),
idSeguradora VARCHAR(10),
PRIMARY KEY(idPedido,idAcidente,idSeguradora)
);

CREATE TABLE Leva (
dataInicio VARCHAR(10),
dataFim VARCHAR(10),
idVeículo VARCHAR(10),
idContainer VARCHAR(10),
FOREIGN KEY(idVeículo) REFERENCES Veiculo (idVeículo),
FOREIGN KEY(idContainer) REFERENCES Container (idContainer)
);

CREATE TABLE Despacha (
dataRecebimento VARCHAR(10),
dataDespacho VARCHAR(10),
idPedido VARCHAR(10),
idUnidade VARCHAR(10),
FOREIGN KEY(idPedido) REFERENCES Pedido (idPedido),
FOREIGN KEY(idUnidade) REFERENCES Unidade (idUnidade)
);

CREATE TABLE Estoca (
data VARCHAR(10),
idLote VARCHAR(10),
idContainer VARCHAR(10),
PRIMARY KEY(idLote,idContainer)
);

CREATE TABLE Contem (
idProduto VARCHAR(10),
idContainer VARCHAR(10),
FOREIGN KEY(idProduto) REFERENCES Produto (idProduto),
FOREIGN KEY(idContainer) REFERENCES Container (idContainer)
);

CREATE TABLE Conduz (
idVeículo VARCHAR(10),
FOREIGN KEY(idVeículo) REFERENCES Veiculo (idVeículo)
);

ALTER TABLE PessoaFisica ADD FOREIGN KEY(idCliente) REFERENCES Cliente (idCliente);
ALTER TABLE PessoaJuridica ADD FOREIGN KEY(idCliente) REFERENCES Cliente (idCliente);
ALTER TABLE Produto ADD FOREIGN KEY(idPedido) REFERENCES Pedido (idPedido);
ALTER TABLE Armazem ADD FOREIGN KEY(idUnidade) REFERENCES Unidade (idUnidade);
ALTER TABLE Pedido ADD FOREIGN KEY(idCliente) REFERENCES Cliente (idCliente);
