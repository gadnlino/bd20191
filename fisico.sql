USE remote_mysql;

/*__________________________REMOÇÃO DAS TABELAS______________________*/

DROP TABLE IF exists PessoaFisica;
DROP TABLE IF exists PessoaJuridica;
DROP TABLE IF exists ContainerSuporta;
DROP TABLE IF exists Contem;
DROP TABLE IF exists Despacha;
DROP TABLE IF exists Leva;
DROP TABLE IF exists Cobre;
DROP TABLE IF exists Produto;
DROP TABLE IF exists TipoProduto;
DROP TABLE IF exists Acidente;
DROP TABLE IF exists Seguradora;
DROP TABLE IF exists Pedido;
DROP TABLE IF exists Cliente;
DROP TABLE IF exists Rota;
DROP TABLE IF exists Estoca;
DROP TABLE IF exists Estoquista;
DROP TABLE IF exists Motorista;
DROP TABLE IF exists Maquinista;
DROP TABLE IF exists Capitao;
DROP TABLE IF exists Caminhoneiro;
DROP TABLE IF exists Funcionario;
DROP TABLE IF exists TransportesDisponiveis;
DROP TABLE IF exists Container;
DROP TABLE IF exists Lote;
DROP TABLE IF exists Armazem;
DROP TABLE IF exists Caminhao;
DROP TABLE IF exists Navio;
DROP TABLE IF exists Trem;
DROP TABLE IF exists Conduz;
DROP TABLE IF exists Transporta_Transporte;
DROP TABLE IF exists Veiculo;
DROP TABLE IF exists TipoVeiculo;
DROP TABLE IF exists Unidade;

/*____________________________CRIAÇÃO DAS TABELAS______________________________*/

/*OBSERVAÇÃO IMPORTANTE: as definições de chaves estrangeiras estão no final do script,
na parte "DEFINIÇÃO DE CHAVES ESTRANGEIRAS" */

CREATE TABLE Acidente (
	/*Função: guarda informações sobre acidentes em transportes realizados pela empresa*/

	idAcidente_PK INT PRIMARY KEY,
	descricao VARCHAR(600),
	dataAcidente DATE,
	/*Checa se a data do acidente não está no futuro*/
	CONSTRAINT CHK_dataAcidente_notInFuture
		CHECK(dataAcidente <= DATE(SYSDATE())),
	
	idVeiculo_FK INT
);

CREATE TABLE Armazem (
	/*Função: guardar as informações fisicas e de disponibilidade de um armazém.*/

	largura FLOAT,
	altura FLOAT,
	idArmazem_PK INT PRIMARY KEY NOT NULL,
	numMaxContainers INT,

	/*Checa se o número máximo de containers em um armazem está entre 50 e 200, 
			quantidade padrão da empresa. */
	CONSTRAINT CHK_numMaxContainers 
		CHECK(numMaxContainers >= 50 AND numMaxContainers <= 200),

	comprimento FLOAT,
	lotacaoAtual INT,
	idUnidade_FK INT NOT NULL
);

CREATE TABLE Caminhao (
	idVeiculo_SPK INT PRIMARY KEY
);

CREATE TABLE Caminhoneiro (
	cnh VARCHAR(11) UNIQUE,
	idFuncionario_SPK INT PRIMARY KEY
);

CREATE TABLE Capitao (
	ARRAIS VARCHAR(10) UNIQUE,
	idFuncionario_SPK INT PRIMARY KEY
);

CREATE TABLE Cliente (
	/*Função: guardar as informações gerais de um cliente
				(email, endereço, telefone, etc)*/
	idCliente_PK INT PRIMARY KEY,
	cep VARCHAR(8),
	emailCliente VARCHAR(60),

	/*Checa se o email do cliente está no formato x@y.z */
	CONSTRAINT CHK_emailCliente
		CHECK(emailCliente LIKE '%_@_%._%'),

	nome VARCHAR(30),
	endereco VARCHAR(30),
	telefone VARCHAR(11)
);

CREATE TABLE Conduz (
	/*Função: guarda info. de qual motorista conduziu qual tipo de veículo um motorista conduz.*/

	/*Chave estrangeira, indica qual o tipo de véiculo*/
	idVeiculo_FK INT
);

CREATE TABLE Container (
	/*Função: guarda infos. sobre um container da empresa(caracteristicas fisicas, 
				status, vida util em meses, lotação atual, etc)*/

	idContainer_PK INT PRIMARY KEY,
	dataAquisicao DATE,

	/*Checa se a data de aquisição do container não está no futuro*/
	CONSTRAINT CHK_dataAquisicao_notInFuture
		CHECK(dataAquisicao <= DATE(SYSDATE())),

	comprimento DOUBLE,
	altura DOUBLE,
	largura DOUBLE,
	capacidade DOUBLE,
	statusContainer ENUM('Em uso','Disponivel','Em manutenção', 'Desmobilizado'),

	/* Vida util em meses */
	vidaUtil INT,

	lotacaoAtual INT,

	/*Chave estrangeira, indica o lote em que se encontra o container*/
	idLote_FK INT,

	disponibilidade BOOLEAN
);

CREATE TABLE ContainerSuporta(
	idContainer_FK INT,
	idTipoProduto_FK INT
);

CREATE TABLE Contem (
	/*Função: guarda info. de qual container contém qual produto.*/

	/*Chave estrangeira, indica o produto que está sendo transportado*/
	idProduto_FK INT,

	/*Chave estrangeira, indica o container que está transportando*/
	idContainer_FK INT
);

CREATE TABLE Cobre (
	/*Função: guarda info. de qual segurado cobriu qual pedido e em qual tipo de acidente*/

	/*Chave estrangeira, indica qual pedido foi o pedido coberto*/
	idPedido_SPK INT,

	/*Chave estrangeira, indica qual foi o tipo de acidente*/
	idAcidente_SPK INT,

	/*Chave estrangeira, indica qual a seguradora que cobriu o pedido*/
	idSeguradora_SPK INT,

	PRIMARY KEY(idPedido_SPK,idAcidente_SPK,idSeguradora_SPK)
);

CREATE TABLE Despacha (
	/*Função: guarda info. de qual unidade recebeu e despachou um pedido,
				e em qual data.*/

	dataRecebimento DATE,
	dataDespacho DATE,
	/*Checa se a data de recebimento vem antes da data de Despacho*/
	CONSTRAINT CHK_dataRecebimento
		CHECK(dataRecebimento < dataDespacho),
	/*Checa se a data de despacho não está no futuro*/
	CONSTRAINT CHK_dataDespacho_notInFuture
		CHECK(dataDespacho <= DATE(SYSDATE())),

	/*Chave estrangeira, indica qual pedido foi despachado*/
	idPedido_FK INT,

	/*Chave estrangeira, indica qual unidade despachou o pedido*/
	idUnidade_FK INT
);

CREATE TABLE Estoca (
	/*Função: guarda info. de quando um container foi alocado e em qual lote.*/

	dataEstoc DATETIME,
	/*Checa se a data de estocagem não está no futuro*/
	CONSTRAINT CHK_dataEstoc_notInFuture
		CHECK(dataEstoc <= SYSDATE()),

	/*Chave estrangeira, indica em qual lote o container foi alocado*/
	idLote_SPK INT,

	/*Chave estrangeira, indica qual container está transportando*/
	idContainer_SPK INT,

	/*Chave estrageira, indica qual estoquista estocou o containainer*/
	idEstoquista_SPK INT,

	PRIMARY KEY(idLote_SPK,idContainer_SPK,idEstoquista_SPK,dataEstoc)
);

CREATE TABLE Estoquista (
	idFuncionario_SPK INT PRIMARY KEY
);

CREATE TABLE Funcionario (
	/*Função: guarda infos. gerais sobre um funcionário(email, 
				matricula, departamento, endereço, etc)*/

	nome VARCHAR(50),
	emailFuncionario VARCHAR(60),

	/*Checa se o email do funcionário está no formato x@y.z */
	CONSTRAINT CHK_emailFuncionario
		CHECK(emailFuncionario LIKE '%_@_%._%'),

	dataContratacao DATE,

	/*Checa se a data da contratação do funcionário não está no futuro*/
	CONSTRAINT CHK_dataContratacao_notInFuture
		CHECK(dataContratacao <= DATE(SYSDATE())),

	salario float,
	endereco VARCHAR(30),
	matricula VARCHAR(10) UNIQUE,
	rg VARCHAR(9) UNIQUE,
	idFuncionario_PK INT NOT NULL PRIMARY KEY,
	telefone VARCHAR(11),
	dataNascimento DATE,

	/*Impede que a data de nascimento do funcionário esteja posterior a 
			data de sua contratação*/
	CONSTRAINT CHK_dataContratacao_nascimento
		CHECK(dataNascimento < dataContratacao),
	/*Checa se a data da contratação do funcionário não está no futuro*/
	CONSTRAINT CHK_dataNascimento_notInFuture
		CHECK(dataNascimento <= DATE(SYSDATE())),

	departamento VARCHAR(30),

	/*Chave estrangeira, indica qual unidade o funcionário trabalha*/
	idUnidade_FK INT
);

CREATE TABLE Leva (
	dataInicio DATE,
	dataFim DATE,

	/*Checa se a data de inicio é menor do que a dataFim*/
	CONSTRAINT CHK_dataFim
		CHECK(dataInicio <= dataFim),

	/*Checa de a dataFim não está no futuro*/
	CONSTRAINT CHK_dataFimLeva_notInfuture
		CHECK(dataFim <= DATE(SYSDATE())),
	
	idVeiculo_FK INT,
	idContainer_FK INT
);

CREATE TABLE Lote (
	/*Função: guarda informações sobre um espaço específico no armazem
			(cada "vaga" no "estacionamento")*/

	idLote_PK INT,
	setor INT ,
	posicao INT ,

	/*Chave estrangeira, indica a qual armazem esse lote pertence*/
	idArmazem_FK INT NOT NULL,

	PRIMARY KEY(idLote_PK, idArmazem_FK, setor, posicao)
);

CREATE TABLE Maquinista (
	autorizacao VARCHAR(20),
	idFuncionario_SPK INT PRIMARY KEY
);

CREATE TABLE Motorista (
	emViagem BOOLEAN,
	idFuncionario_SPK INT PRIMARY KEY
);

CREATE TABLE Navio (
	idVeiculo_SPK INT PRIMARY KEY
);

CREATE TABLE Pedido (
	/*Função: guardar as informações sobre um pedido
				(qual cliente solicitou,datas de solicitação e entrega,
						qual o destinatário, etc)*/

	idPedido_PK INT PRIMARY KEY,

	dataEntrega DATE,

	/*Impede que a data de entrega esteja no futuro*/ 
	CONSTRAINT CHK_dataEntrega_notInFuture
		CHECK(dataEntrega <= DATE(SYSDATE())),

	dataSolicitacao DATE,

	/*Impede que a data da entrega aconteça antes que o pedido tenha sido solicitado*/ 
	CONSTRAINT CHK_dataEntrega
		CHECK(dataSolicitacao <= dataEntrega),
	/*Impede que a data de solicitação esteja no futuro*/ 
	CONSTRAINT CHK_dataSolicitacao_notInFuture
		CHECK(dataSolicitacao <= DATE(SYSDATE())),


	destino VARCHAR(30),
	statusPedido ENUM('Não entregue','Em rota','Entregue'),
	destinatario VARCHAR(30),

	/*Chave estrangeira, indica qual cliente solicitou esse pedido*/
	idCliente_FK INT
);

CREATE TABLE PessoaFisica(

	/*Função: guardar as informações específicas do cliente que
		é cadastrado como pessoa física(cpf e RG, por exemplo).*/

	cpf VARCHAR(11) UNIQUE,
	rg VARCHAR(9) UNIQUE,

	/*Chave estrangeira, que aponta para a instância 
		de Cliente que é criada no momento do cadastro*/
	idCliente_SPK INT 
);

CREATE TABLE PessoaJuridica (
	/*Função: guardar as informações específicas do cliente que
		é cadastrado como pessoa jurídica(cnpj e razão social, por exemplo).*/

	cnpj VARCHAR(14) UNIQUE,
	razaoSocial VARCHAR(50),

	/*Chave estrangeira, que aponta para a instância 
		de Cliente que é criada no momento do cadastro*/
	idCliente_SPK INT 
);

CREATE TABLE Produto (
	/*Função: guarda infos. sobre um produto que está sendo transportado(descrição, 
				caracteristicas fisicas, pedido a qual o produto pertence, etc)*/
	idProduto_PK INT PRIMARY KEY,
	comprimento DOUBLE,
	descricao VARCHAR(500),
	peso DOUBLE,
	largura DOUBLE,
	altura DOUBLE,

	/*Chave estrangeira, indica qual pedido o produto pertence*/
	idPedido_FK INT,
	tipoProduto_FK INT
);

CREATE TABLE Rota (
	/*Função: indica que há um caminho entre as unidadeOrigem e unidadeDestino*/

	idRota_PK INT PRIMARY KEY,
	/*Chave estrangeira, aponta para a unidade de origem*/
	idUnidadeOrigem_FK INT,

	/*Chave estrangeira, aponta para a unidade de destino*/
	idUnidadeDestino_FK INT,

	idTipoVeiculo_FK INT
	/*Checa se a unidade de origem e destino sao diferentes*/
	/*CONSTRAINT CHK_destinoDiferenteOrigem
		CHECK(idUnidadeDestino_SPK != idUnidadeOrigem_SPK)*/
);

CREATE TABLE Seguradora (
	/*Função: guardar as informações de uma seguradora, que pode ou não 
				cobrir acidentes que podem acontecer com pedidos que são 
						transportados pela empresa;*/


	idSeguradora_PK INT PRIMARY KEY,
	emailSeguradora VARCHAR(60),

	/*Checa se o email da seguradora está no formato x@y.z */
	CONSTRAINT CHK_emailSeguradora
		CHECK(emailSeguradora LIKE '%_@_%._%'),

	cnpj VARCHAR(14) UNIQUE,
	razaoSocial VARCHAR(60),
	nome VARCHAR(60),
	telefone VARCHAR(11)
);

CREATE TABLE Transporta_Transporte (
	/*Função: guarda info. de qual veiculo transporta qual container, e em qual data*/

	/*Chave estrangeira, indica qual container esta sendo transportado*/
	idContainer_SPK INT,

	/*Chave estrangeira, indica qual veiculo está transportando*/
	idVeiculo_SPK INT,

	dataInicio DATE,
	dataFim DATE,

	/*Impede que a data de inicio do tranporte seja posterior a data de termino*/
	CONSTRAINT CHK_dataInicio
		CHECK(dataInicio < dataFim),
	CONSTRAINT CHK_dataFimTransporte_notInfuture
		CHECK(dataFim <= DATE(SYSDATE())),

	PRIMARY KEY(idContainer_SPK,idVeiculo_SPK)
);

CREATE TABLE TipoProduto (
	idTipoProduto_PK INT PRIMARY KEY,
	descricao VARCHAR(20)
);

CREATE TABLE TipoVeiculo (
	/*Função: guarda info. de cada tipo de veículo*/

	idTipoVeiculo_PK INT PRIMARY KEY,
	nome VARCHAR(50),
	numMaxContainers INT

);

CREATE TABLE Trem (
	idVeiculo_SPK INT PRIMARY KEY
);

CREATE TABLE Unidade (
	/*Função: guardar as informações sobre cada unidade da empresa
				(email,telefone, qual tipo de transporte está disponivel, etc)*/

	emailUnidade VARCHAR(60),

	/*Checa se o email da unidade está no formato x@y.z */
	CONSTRAINT CHK_emailUnidade
		CHECK(emailUnidade LIKE '%_@_%._%'),

	endereco VARCHAR(30),
	idUnidade_PK INT PRIMARY KEY NOT NULL,
	cep VARCHAR(8),
	telefone VARCHAR(11),
	caminhaoDisponivel BOOLEAN,
	navioDisponivel BOOLEAN,
	tremDisponivel BOOLEAN
);

CREATE TABLE Veiculo (
	/*Função: guarda infos. gerais sobre um veiculo da empresa(carga maxima em quilos, 
				numero máximo de containers, tipo do veículo, localização, unidade de origem, etc)*/
	idVeiculo_PK INT,
	localizacao VARCHAR(30),
	fabricante VARCHAR(20),
	capacidadeCombustivel DOUBLE,

	/*Carga máxima em quilos*/
	cargaMaxima DOUBLE,

	/*Status do veículo*/
	statusVeiculo ENUM('Disponivel','Em uso','Em manutenção','Desmobilizado'),

	/*Chave estrangeira, indica qual a unidade de origem do veículo*/
	unidadeOrigem_FK INT,

	/*Tempo de utilização em meses*/
	tempoUtilizacao INT,

	lotacaoAtual INT,

	/*Checa se a lotação atual nao é maior do que a capacidade maxima do veiculo*/
	/*CONSTRAINT CHK_lotacaoContainer
		CHECK(lotacaoAtual <= numMaxContainers),*/

	disponibilidade BOOLEAN,
	idTipoVeiculo_FK INT,

	PRIMARY KEY(idVeiculo_PK,idTipoVeiculo_FK)
);

/*_________________________DEFINIÇÃO DE CHAVES ESTRANGEIRAS_________________________________*/

/*Chaves estrangeiras da tabela Acidente*/
ALTER TABLE Acidente ADD FOREIGN KEY (idVeiculo_FK) REFERENCES Veiculo(idVeiculo_PK)
	ON UPDATE CASCADE;

/*Chaves estrangeiras da tabela Armazem*/
ALTER TABLE Armazem ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK) 
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Caminhao*/
ALTER TABLE Caminhao ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Caminhoneiro*/
ALTER TABLE Caminhoneiro ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Capitao*/
ALTER TABLE Capitao ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Cobre*/
ALTER TABLE Cobre ADD FOREIGN KEY(idPedido_SPK) REFERENCES Pedido(idPedido_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Cobre ADD FOREIGN KEY(idAcidente_SPK) REFERENCES Acidente(idAcidente_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Cobre ADD FOREIGN KEY(idSeguradora_SPK) REFERENCES Seguradora(idSeguradora_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Conduz*/
ALTER TABLE Conduz ADD FOREIGN KEY(idVeiculo_FK) REFERENCES Veiculo (idVeiculo_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Container*/
ALTER TABLE Container ADD FOREIGN KEY(idLote_FK) REFERENCES Lote (idLote_PK);

/*Chaves estrangeiras da tabela ContainerSuporta*/
ALTER TABLE ContainerSuporta ADD FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ContainerSuporta ADD FOREIGN KEY(idTipoProduto_FK) REFERENCES TipoProduto(idTipoProduto_PK)
	ON UPDATE CASCADE ON DELETE SET NULL;

/*Chaves estrangeiras da tabela Contem*/
ALTER TABLE Contem ADD FOREIGN KEY(idProduto_FK) REFERENCES Produto (idProduto_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Contem ADD FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Despacha*/
ALTER TABLE Despacha ADD FOREIGN KEY(idPedido_FK) REFERENCES Pedido (idPedido_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Despacha ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK)
	ON UPDATE CASCADE ON DELETE SET NULL;

/*Chaves estrangeiras da tabela Estoquista*/
ALTER TABLE Estoquista ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Estoca*/
ALTER TABLE Estoca ADD FOREIGN KEY(idLote_SPK) REFERENCES Lote (idLote_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Estoca ADD FOREIGN KEY(idContainer_SPK) REFERENCES Container (idContainer_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Estoca ADD FOREIGN KEY(idEstoquista_SPK) REFERENCES Estoquista (idFuncionario_SPK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Funcionario*/
ALTER TABLE Funcionario ADD FOREIGN KEY(idUnidade_FK) REFERENCES Unidade (idUnidade_PK)
	ON UPDATE CASCADE ON DELETE SET NULL;

/*Chaves estrangeiras da tabela Leva*/
ALTER TABLE Leva ADD FOREIGN KEY(idVeiculo_FK) REFERENCES Veiculo (idVeiculo_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Leva ADD FOREIGN KEY(idContainer_FK) REFERENCES Container (idContainer_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Lote*/
ALTER TABLE Lote ADD FOREIGN KEY(idArmazem_FK) REFERENCES Armazem (idArmazem_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Maquinista*/
ALTER TABLE Maquinista ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Motorista*/
ALTER TABLE Motorista ADD FOREIGN KEY(idFuncionario_SPK) REFERENCES Funcionario (idFuncionario_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Navio*/
ALTER TABLE Navio ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Pedido*/
ALTER TABLE Pedido ADD FOREIGN KEY(idCliente_FK) REFERENCES Cliente (idCliente_PK);

/*Chaves estrangeiras da tabela PessoaFisica*/
ALTER TABLE PessoaFisica ADD FOREIGN KEY(idCliente_SPK) REFERENCES Cliente (idCliente_PK) 
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela PessoaJuridica*/
ALTER TABLE PessoaJuridica ADD FOREIGN KEY(idCliente_SPK) REFERENCES Cliente (idCliente_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Produto*/
ALTER TABLE Produto ADD FOREIGN KEY(idPedido_FK) REFERENCES Pedido (idPedido_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Produto ADD FOREIGN KEY(tipoProduto_FK) REFERENCES TipoProduto (idTipoProduto_PK);

/*Chaves estrangeiras da tabela Rota*/
ALTER TABLE Rota ADD FOREIGN KEY(idTipoVeiculo_FK) REFERENCES TipoVeiculo (idTipoVeiculo_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Rota ADD FOREIGN KEY(idUnidadeOrigem_FK) REFERENCES Unidade (idUnidade_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Rota ADD FOREIGN KEY(idUnidadeDestino_FK) REFERENCES Unidade (idUnidade_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Trem*/
ALTER TABLE Trem ADD FOREIGN KEY(idVeiculo_SPK) REFERENCES Veiculo (idVeiculo_PK)
	ON UPDATE CASCADE ON DELETE CASCADE;

/*Chaves estrangeiras da tabela Veiculo*/
ALTER TABLE Veiculo ADD FOREIGN KEY(unidadeOrigem_FK) REFERENCES Unidade(idUnidade_PK)
	ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE Veiculo ADD FOREIGN KEY(idTipoVeiculo_FK) REFERENCES TipoVeiculo(idTipoVeiculo_PK);