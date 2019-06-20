USE remote_mysql;

/*Remoção das tuplas*/

/*SET FOREIGN_KEY_CHECKS = 0;*/

/*
TRUNCATE TABLE PessoaFisica;
TRUNCATE TABLE PessoaJuridica;
TRUNCATE TABLE TipoProduto;
TRUNCATE TABLE Contem;
TRUNCATE TABLE Despacha;
TRUNCATE TABLE Leva;
TRUNCATE TABLE Cobre;
TRUNCATE TABLE Produto;
TRUNCATE TABLE Acidente;
TRUNCATE TABLE Seguradora;
TRUNCATE TABLE Pedido;
TRUNCATE TABLE Cliente;
TRUNCATE TABLE Rota;
TRUNCATE TABLE Estoca;
TRUNCATE TABLE Estoquista;
TRUNCATE TABLE Motorista;
TRUNCATE TABLE Maquinista;
TRUNCATE TABLE Capitao;
TRUNCATE TABLE Caminhoneiro;
TRUNCATE TABLE Funcionario;
TRUNCATE TABLE TransportesDisponiveis;
TRUNCATE TABLE ProdutosSuportados;
TRUNCATE TABLE Container;
TRUNCATE TABLE Lote;
TRUNCATE TABLE Armazem;
TRUNCATE TABLE Caminhao;
TRUNCATE TABLE Navio;
TRUNCATE TABLE Trem;
TRUNCATE TABLE Conduz;
TRUNCATE TABLE Transporta_Transporte;
TRUNCATE TABLE Veiculo;
TRUNCATE TABLE Unidade;
*/

/*_____________________________CLIENTE_____________________________________*/

 insert into Cliente (idcliente_pk, cep, emailcliente, nome, endereco, telefone) values
(1, 83108184, 'emaudling0@webs.com', 'Emlyn Maudling', '22 Tennessee Junction', '2798678942'),
 (2, 37183203, 'gbeazer1@cam.ac.uk', 'Garald Beazer', '39829 Bunting Circle', '8051765396'),
 (3, 43896814, 'yspick2@posterous.com', 'Yettie Spick', '7 Westerfield Street', '8829909282'),
 (4, 25649381, 'esapauton3@cloudflare.com', 'Edee Sapauton', '10 Charing Cross Street', '8604534377'),
 (5, 77457947, 'rughi4@java.com', 'Richmound Ughi', '9 Jay Road', '8673124426'),
 (6, 27750592, 'phutcheon5@illinois.edu', 'Preston Hutcheon', '4 3rd Junction', '3654571232'),
 (7, 34849688, 'cbirdseye6@bing.com', 'Corrina Birdseye', '1 Stephen Street', '8064818857'),
 (8, 82523045, 'ijachimczak7@ebay.co.uk', 'Irving Jachimczak', '9 Coleman Court', '4054188536'),
 (9, 90625202, 'wvarrow8@webs.com', 'Whitney Varrow', '3597 Cardinal Pass', '6101164045'),
 (10, 93055668, 'keakins9@nydailynews.com', 'Kathe Eakins', '19937 Holy Cross Park', '3209087201'),
 (11, 65230485, 'asimmersa@drupal.org', 'Abba Simmers', '728 Autumn Leaf Court', '1817345215'),
 (12, 66854627, 'pnorleyb@ibm.com', 'Penn Norley', '9386 Fair Oaks Drive', '7306192315'),
 (13, 15499180, 'mmartelc@vimeo.com', 'Morissa Martel', '161 4th Circle', '9838998606'),
 (14, 86525872, 'tromerild@hexun.com', 'Tad Romeril', '626 Stang Crossing', '1193683937'),
 (15, 71475425, 'kknollesgreene@shutterfly.com', 'Kirsten Knolles-Green', '53 Old Shore Parkway', '4566570058'),
 (16, 61794903, 'echelleyf@icio.us', 'Eve Chelley', '54 Haas Road', '7536856601'),
 (17, 79367324, 'jcampeyg@jimdo.com', 'Juana Campey', '90302 Clemons Parkway', '8702819772'),
 (18, 93344329, 'rperassih@fda.gov', 'Reilly Perassi', '072 Onsgard Parkway', '4956121253'),
 (19, 17882454, 'tmaggiorii@fda.gov', 'Tine Maggiori', '16 Scott Avenue', '8256407048'),
 (20, 65651657, 'nburnessj@cbslocal.com', 'Nobie Burness', '86 Montana Court', '3686211811');

/*_____________________________UNIDADE_____________________________________*/

 insert into Unidade (idunidade_pk, emailunidade, endereco, cep, telefone) values
(1, 'nboorne0@flickr.com', '8147 Warbler Lane', 81204605, '7372348838'),
 (2, 'stollfree1@g.co', '18242 Esker Court', 80281182, '1648938667'),
 (3, 'gpitbladdo2@facebook.com', '0 Tony Parkway', 76190888, '1858552526'),
 (4, 'csimison3@nytimes.com', '7 Clyde Gallagher Point', 96973511, '4029350484'),
 (5, 'whowen4@un.org', '0 7th Hill', 90425625, '5707773912'),
 (6, 'cgorick5@unesco.org', '889 Springview Plaza', 50997639, '3627130795'),
 (7, 'gdunckley6@desdev.cn', '40981 Holmberg Place', 29814403, '1444452139'),
 (8, 'llindegard7@flavors.me', '08523 Jenna Lane', 64003071, '5929202353'),
 (9, 'bsemor8@state.tx.us', '338 Lakewood Gardens Point', 60320590, '6497894737'),
 (10, 'dwhales9@forbes.com', '78621 Carpenter Circle', 18034477, '2026672951');

/*_____________________________TIPOVEICULO_____________________________________*/

insert into TipoVeiculo (idTipoVeiculo_PK, nome, numMaxContainers) values
(1, 'Caminhão', 1),
(2, 'Navio', 50),
(3, 'Trem', 20);

/*_____________________________TIPOPRODUTO_____________________________________*/

insert into TipoProduto (idTipoProduto_PK, descricao) values
(1, 'Perecivel'),
(2, 'Não perecivel'),
(3, 'Frágil'),
(4, 'Inflamável'),
(5, 'Substância tóxica'),
(6, 'Carga viva');

/*_____________________________SEGURADORA_____________________________________*/

insert into Seguradora (idseguradora_pk, emailseguradora, cnpj, razaosocial, nome, telefone) values
(1, 'rburdus0@sogou.com', 74840948902839, 'Plajo', 'Riffpedia', '6378410850'),
(2, 'jbrowne1@wunderground.com', 78232328093931, 'Jaloo', 'Topiczoom', '1715075024'),
(3, 'mblacksell2@buzzfeed.com', 42128383071301, 'Reallinks', 'Oyoba', '4125863691'),
(4, 'mheggison3@irs.gov', 15322184981194, 'Gigashots', 'Bluejam', '4038603080');

/*_____________________________ARMAZEM_____________________________________*/

 insert into Armazem (largura, altura, idarmazem_pk, nummaxcontainers, comprimento, lotacaoatual, idunidade_fk) values
(27.6, 70.25, 1, 68, 74.92, 56, 5),
 (64.14, 97.02, 2, 59, 22.47, 66, 2),
 (95.08, 75.26, 3, 103, 61.3, 32, 2),
 (74.56, 35.49, 4, 145, 18.28, 38, 2),
 (45.99, 47.32, 5, 158, 45.65, 49, 1),
 (99.46, 29.36, 6, 194, 14.76, 74, 3),
 (78.74, 21.85, 7, 142, 74.14, 121, 10),
 (89.6, 49.02, 8, 162, 62.82, 177, 1),
 (39.27, 28.53, 9, 197, 23.8, 12, 5),
 (19.93, 7.67, 10, 147, 35.8, 154, 7),
 (98.64, 35.14, 11, 122, 57.89, 142, 1),
 (94.42, 85.07, 12, 68, 47.21, 42, 10),
 (50.66, 96.84, 13, 199, 90.5, 4, 7),
 (68.98, 66.46, 14, 141, 68.83, 130, 4),
 (85.46, 60.93, 15, 186, 34.4, 86, 8),
 (29.64, 27.41, 16, 68, 82.37, 97, 9),
 (83.03, 4.75, 17, 128, 30.18, 108, 9),
 (81.87, 85.35, 18, 132, 68.32, 71, 9),
 (44.49, 41.02, 19, 179, 97.84, 42, 6),
 (45.72, 5.17, 20, 184, 59.11, 86, 6);

/*_____________________________PEDIDO_____________________________________*/

 insert into Pedido (idpedido_pk, dataentrega, datasolicitacao, destino, statuspedido, destinatario, idcliente_fk) values
  (1, '2019-01-28', '2018-12-20', '31 Hintze Road', 'Não entregue', 'Nat Linneman', 8),
 (2, '2019-04-05', '2018-12-24', '28 Dennis Avenue', 'Não entregue', 'Killie Pindred', 17),
 (3, '2019-02-04', '2018-11-06', '9816 Leroy Terrace', 'Não entregue', 'Aldo Seally', 1),
 (4, '2019-05-13', '2018-06-25', '52 Glendale Parkway', 'Em rota', 'Justus Jeste', 19),
 (5, '2019-05-26', '2018-11-11', '5252 Bluejay Road', 'Em rota', 'Gwenette Cardenas', 3),
 (6, '2019-02-01', '2018-10-30', '2244 Becker Parkway', 'Entregue', 'Paxton Pierri', 15),
 (7, '2019-01-11', '2018-12-26', '0 Golden Leaf Street', 'Em rota', 'Ralph Tremayle', 1),
 (8, '2019-05-08', '2018-12-02', '4050 Mayfield Street', 'Entregue', 'Brietta Bolesworth', 13),
 (9, '2019-05-22', '2018-12-16', '4179 Kings Point', 'Não entregue', 'Harmonie Carrabot', 14),
 (10, '2019-01-24', '2018-06-18', '487 Talisman Avenue', 'Em rota', 'Vonnie Oleszkiewicz', 18),
 (11, '2019-03-03', '2018-06-28', '3437 Sherman Hill', 'Em rota', 'Raimondo Camerati', 1),
 (12, '2019-03-02', '2018-10-06', '7675 Division Way', 'Não entregue', 'Carey Gerald', 4),
 (13, '2019-04-20', '2018-11-21', '663 Hanson Street', 'Não entregue', 'Shannon Venables', 7),
 (14, '2019-05-07', '2018-08-02', '0213 Stoughton Center', 'Não entregue', 'Josi Blackstone', 10),
 (15, '2019-04-05', '2018-07-31', '652 Dexter Parkway', 'Em rota', 'Fonz Thumann', 5),
 (16, '2019-03-01', '2018-06-22', '5186 Del Sol Circle', 'Em rota', 'Guillema Yarham', 11),
 (17, '2019-05-26', '2018-09-04', '370 Linden Park', 'Não entregue', 'Carolynn Feetham', 6),
 (18, '2019-04-19', '2018-07-13', '1 Barnett Pass', 'Em rota', 'Nydia Shafier', 14),
 (19, '2019-01-31', '2018-08-18', '81011 Thierer Plaza', 'Não entregue', 'Wit Rentalll', 5),
 (20, '2019-04-07', '2018-06-28', '7 Monument Junction', 'Em rota', 'Roxie Perutto', 11);

/*_____________________________PRODUTO_____________________________________*/

  insert into Produto (idproduto_pk, comprimento, descricao, peso, largura, altura, idpedido_fk, tipoproduto_fk) values
  (1, 10.4, 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', 37.13, 26.51, 13.49, 10, 3),
 (2, 47.96, 'Nunc rhoncus dui vel sem.', 96.95, 7.2, 16.7, 4, 4),
 (3, 37.46, 'Morbi a ipsum. Integer a nibh. In quis justo.', 63.43, 64.61, 43.77, 15, 2),
 (4, 37.46, 'Donec vitae nisi.', 78.99, 38.65, 41.14, 8, 3),
 (5, 49.24, 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', 81.18, 69.31, 23.08, 1, 2),
 (6, 72.2, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 10.09, 39.19, 97.67, 15, 3),
 (7, 67.17, 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', 47.32, 88.54, 83.02, 7, 3),
 (8, 20.07, 'Curabitur in libero ut massa volutpat convallis.', 41.93, 30.85, 38.31, 5, 5),
 (9, 10.88, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 6.38, 60.46, 21.74, 12, 3),
 (10, 35.59, 'Etiam justo. Etiam pretium iaculis justo.', 18.99, 90.02, 30.01, 12, 5),
 (11, 14.47, 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 4.45, 80.39, 5.23, 20, 2),
 (12, 83.87, 'Donec ut dolor.', 20.83, 25.75, 68.47, 3, 4),
 (13, 92.37, 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 76.01, 41.25, 35.85, 10, 1),
 (14, 77.01, 'Vivamus vestibulum sagittis sapien.', 67.64, 93.17, 64.73, 15, 3),
 (15, 5.73, 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.', 59.47, 37.79, 65.76, 5, 5),
 (16, 5.43, 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 35.38, 79.94, 86.74, 13, 4),
 (17, 24.74, 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 71.68, 13.41, 65.62, 17, 5),
 (18, 71.56, 'Quisque porta volutpat erat.', 65.49, 55.05, 71.01, 19, 5),
 (19, 96.92, 'Praesent lectus.', 42.83, 78.02, 9.0, 2, 2),
 (20, 93.94, 'Fusce consequat.', 30.9, 89.46, 85.15, 13, 5);

/*_____________________________LOTE_____________________________________*/

insert into Lote (idLote_PK,setor,posicao,idArmazem_FK)
values
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 2, 1, 1),
(5, 2, 2, 1),
(6, 2, 3, 1),
(7, 1, 1, 2);

/*_____________________________CONTAINER_____________________________________*/

 insert into Container (idcontainer_pk, dataaquisicao, comprimento, altura, largura, capacidade, statuscontainer, vidautil, lotacaoatual, idlote_fk, disponibilidade) values
  (1, '2015-07-18', 4.1, 56.93, 16.2, 6763, 'Em uso', 33, 1, 1, true),
 (2, '2019-01-03', 57.16, 10.08, 14.59, 5061, 'Em uso', 195, 1, 2, true),
 (3, '2006-03-10', 78.04, 48.52, 74.23, 2658, 'Em manutenção', 106, 1, 3, true),
 (7, '2013-09-17', 76.03, 37.64, 3.14, 6305, 'Desmobilizado', 101, 1, 4, true),
 (8, '2012-11-23', 14.88, 91.44, 36.32, 7768, 'Em manutenção', 193, 2, 5, true),
 (9, '2003-07-01', 5.06, 18.36, 17.15, 116, 'Disponivel', 43, 1, 6, true),
 (10, '2000-10-13', 28.59, 56.29, 40.04, 2237, 'Desmobilizado', 200, 1, 7, true);

/*_____________________________CONTAINERSUPORTA_____________________________________*/

 insert into ContainerSuporta (idcontainer_fk, idtipoproduto_fk) values
 (1, 3),
 (3, 4),
 (9, 2),
 (7, 3),
 (1, 2),
 (3, 3),
 (8, 2),
 (2, 5),
 (8, 5),
 (2, 4),
 (1, 5),
 (7, 1),
 (9, 4),
 (10, 2),
 (9, 1),
 (10, 1),
 (1, 1),
 (2, 1);

/*_____________________________FUNCIONARIO_____________________________________*/

 insert into Funcionario (nome, emailfuncionario, datacontratacao, salario, endereco, matricula, rg, idfuncionario_pk, telefone, datanascimento, departamento, idunidade_fk) values
 ('Viole Dashkovich', 'vdashkovich0@aol.com', '2019-01-21', 45.14, '64267 Northland Alley', '19-9865098', 72089161, 1, '5491633561', '1973-12-26', 'Accounting', 1),
 ('Arabela Goodin', 'agoodin1@vistaprint.com', '2019-04-18', 9686.56, '496 Granby Parkway', '37-6129214', 20361907, 2, '8259565698', '1998-02-12', 'Services', 3),
 ('Noami Schrieves', 'nschrieves2@tumblr.com', '2018-12-26', 9298.3, '9 Clarendon Trail', '18-8725106', 38249238, 3, '4022980756', '1980-08-20', 'Services', 4),
 ('Bram MacNeilly', 'bmacneilly3@hao123.com', '2018-07-23', 6243.92, '9899 Butterfield Trail', '40-8822809', 97582956, 4, '8447281517', '1975-07-01', 'Human Resources', 5),
 ('Colin Fairbrass', 'cfairbrass4@unc.edu', '2019-05-17', 947.63, '2832 Randy Crossing', '63-9594293', 7047968, 5, '7957179561', '1999-03-21', 'Sales', 10),
 ('Bartram Scanlin', 'bscanlin5@omniture.com', '2018-09-19', 9381.59, '8338 Swallow Road', '01-1829339', 23707195, 6, '4005063788', '1976-03-18', 'Services', 8),
 ('Burt Rosel', 'brosel6@ustream.tv', '2018-08-17', 8592.39, '8 Summer Ridge Terrace', '19-1442822', 25759497, 7, '3525777465', '1991-06-19', 'Sales', 9),
 ('Torrance O''Towey', 'totowey7@wikispaces.com', '2019-03-15', 5713.38, '7814 Waubesa Alley', '99-3568337', 76561142, 8, '8264393065', '1975-03-14', 'Support', 3),
 ('Pavel Advani', 'padvani8@wordpress.com', '2019-03-08', 5737.94, '6639 Crescent Oaks Street', '10-4982702', 70968155, 9, '6365923548', '1975-06-15', 'Business Development', 6),
 ('Kelbee Drance', 'kdrance9@cam.ac.uk', '2019-03-16', 1597.11, '11329 Fulton Plaza', '44-9850730', 84447232, 10, '2825944955', '1974-06-06', 'Training', 5),
 ('Sloane Dionisi', 'sdionisia@bigcartel.com', '2019-05-04', 8690.27, '0075 Mifflin Street', '27-8539572', 28576413, 11, '2057776398', '1976-08-10', 'Engineering', 10),
 ('Grethel Dunthorn', 'gdunthornb@bravesites.com', '2019-06-15', 975.75, '13510 Lakeland Way', '34-1566434', 40111740, 12, '3576504897', '1982-06-25', 'Research and Development', 10),
 ('Carolyn Golsby', 'cgolsbyc@twitpic.com', '2018-10-13', 7727.11, '04 Sullivan Place', '99-7269431', 32361883, 13, '8975088597', '1970-11-26', 'Engineering', 9),
 ('Shirleen Geal', 'sgeald@wsj.com', '2018-11-17', 9949.61, '4 Monica Drive', '92-3628215', 23782008, 14, '5832494808', '1977-05-13', 'Engineering', 9),
 ('Moria Surgeon', 'msurgeone@parallels.com', '2019-02-07', 5357.45, '25554 Burning Wood Terrace', '86-3717490', 72705882, 15, '2655951428', '1987-06-27', 'Services', 4),
 ('Zuzana Valadez', 'zvaladezf@sciencedirect.com', '2018-10-21', 8317.16, '1815 Harbort Circle', '73-6220684', 42805842, 16, '5758732596', '1975-01-10', 'Services', 3),
 ('Stephannie Meadley', 'smeadleyg@vimeo.com', '2018-10-14', 3585.98, '34 Heffernan Point', '13-1239927', 85812692, 17, '4448468907', '1995-12-24', 'Support', 8),
 ('Darlleen Hubber', 'dhubberh@networksolutions.com', '2019-03-11', 8015.49, '1 Dahle Court', '45-1738355', 48711238, 18, '1733710516', '1999-02-01', 'Services', 3),
 ('Stanley Baradel', 'sbaradeli@simplemachines.org', '2018-06-27', 6307.8, '3 Cordelia Lane', '60-9390393', 23770269, 19, '4399161969', '1993-04-29', 'Support', 3),
 ('Ki Hayne', 'khaynej@reverbnation.com', '2019-04-03', 2713.15, '4643 Amoth Hill', '58-2207544', 53548117, 20, '4963107630', '1998-09-22', 'Training', 9);

/*_____________________________VEICULO_____________________________________*/
  
  insert into Veiculo (idveiculo_pk, localizacao, fabricante, capacidadecombustivel, cargamaxima, statusveiculo, unidadeorigem_fk, tempoutilizacao, lotacaoatual, disponibilidade, idTipoVeiculo_FK) values
(23, '1 Waxwing Center', 'Devbug', 85.96, 945.74, 'Em uso', 7, 31, 12, true, 3),
 (56, '1906 Coolidge Street', 'Yamia', 37.02, 445.3, 'Em manutenção', 9, 6, 3, true, 2),
 (54, '0750 Arizona Parkway', 'Tekfly', 13.57, 674.1, 'Em uso', 5, 39, 40, false, 2),
 (59, '2045 Weeping Birch Junction', 'Bubblebox', 31.92, 573.47, 'Em uso', 4, 41, 34, true, 3),
 (42, '873 Boyd Plaza', 'Quinu', 27.46, 801.64, 'Em uso', 4, 9, 41, true, 3),
 (41, '339 Katie Place', 'Muxo', 78.97, 847.32, 'Em uso', 6, 19, 33, false, 2),
 (3, '26343 Delaware Center', 'Voonyx', 83.03, 388.78, 'Desmobilizado', 10, 6, 2, false, 3),
 (18, '16460 Weeping Birch Trail', 'Tekfly', 21.67, 322.44, 'Em uso', 1, 10, 48, false, 2),
 (12, '52 Daystar Circle', 'Skynoodle', 55.29, 804.5, 'Desmobilizado', 6, 46, 10, true, 2),
 (39, '879 Brickson Park Circle', 'Quinu', 18.04, 259.4, 'Em uso', 1, 29, 14, true, 2),
 (19, '0514 Farmco Trail', 'Topiczoom', 40.16, 250.44, 'Desmobilizado', 5, 43, 41, true, 2),
 (80, '87 Stephen Plaza', 'Mynte', 49.6, 159.77, 'Disponivel', 2, 14, 35, false, 2),
 (45, '22029 Maple Terrace', 'Trilith', 30.3, 786.98, 'Disponivel', 9, 24, 2, false, 3),
 (10, '05446 Straubel Way', 'Avaveo', 33.6, 396.0, 'Disponivel', 1, 9, 11, false, 2);

 /*_____________________________ROTA_____________________________________*/

 insert into Rota (idrota_pk, idunidadeorigem_fk, idunidadedestino_fk, idtipoveiculo_fk) values
(1, 2, 3, 2),
 (2, 3, 5, 2),
 (3, 2, 2, 3),
 (4, 7, 5, 3),
 (5, 5, 8, 3),
 (6, 7, 7, 2),
 (7, 7, 7, 3),
 (8, 4, 6, 1),
 (9, 3, 4, 2),
 (10, 1, 10, 3),
 (11, 9, 10, 2),
 (12, 10, 4, 1),
 (13, 1, 5, 1),
 (14, 10, 10, 2),
 (15, 7, 9, 1);

/*_____________________________TRANSPORTA_TRANSPORTE_____________________________________*/

 insert into Transporta_Transporte (idcontainer_spk, idveiculo_spk, datainicio, datafim) values
 (2, 54, '2018-09-25', '2019-05-25'),
 (1, 12, '2018-04-16', '2019-04-16'),
 (8, 56, '2018-10-20', '2019-03-13'),
 (3, 41, '2018-07-17', '2019-03-23'),
 (7, 3, '2018-04-02', '2019-05-26'),
 (10, 12, '2018-08-05', '2019-05-26'),
 (1, 23, '2018-02-15', '2019-02-13'),
 (10, 3, '2018-12-05', '2019-04-08'),
 (7, 41, '2018-01-04', '2019-05-19'),
 (1, 59, '2018-08-25', '2019-02-06'),
 (9, 56, '2018-09-26', '2019-05-02'),
 (8, 12, '2018-08-31', '2019-01-28'),
 (3, 56, '2018-11-15', '2019-05-05'),
 (8, 42, '2018-11-18', '2019-01-16'),
 (2, 12, '2018-06-07', '2019-06-01'),
 (7, 56, '2018-10-29', '2019-03-12'),
 (10, 18, '2018-10-07', '2019-05-10'),
 (10, 56, '2018-07-26', '2019-06-08'),
 (9, 12, '2018-09-11', '2019-02-01'),
 (9, 41, '2018-12-07', '2019-05-05');

/*_____________________________CONTEM_____________________________________*/

 insert into Contem (idproduto_fk, idcontainer_fk) values
 (18, 8),
 (1, 7),
 (10, 7),
 (8, 8),
 (13, 8),
 (18, 3),
 (5, 1),
 (5, 7),
 (8, 1),
 (9, 8),
 (3, 1),
 (6, 1),
 (8, 3),
 (3, 1),
 (17, 10);

/*_____________________________ACIDENTE_____________________________________*/

 insert into Acidente (idacidente_pk, descricao, dataacidente, idveiculo_fk) values
(1, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.', '2018-11-18', 56),
 (2, 'Nunc rhoncus dui vel sem. Sed sagittis.', '2018-06-23', 3),
 (3, 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', '2018-11-23', 41),
 (4, 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2018-07-29', 12),
 (5, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.', '2019-02-22', 80),
 (6, 'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', '2019-03-05', 54),
 (7, 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', '2018-12-06', 42),
 (8, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '2019-02-02', 41),
 (9, 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.', '2019-05-23', 12),
 (10, 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '2018-07-11', 59);

/*_____________________________PESSOAFISICA________________________________*/

 insert into PessoaFisica (cpf, rg, idcliente_spk) values
(12307464, 742823667, 1),
 (12237248, 215650067, 2),
 (98844830, 803770109, 3),
 (78875560, 187983078, 4),
 (84748551, 547885409, 5),
 (42704120, 354806024, 6),
 (56590045, 846890239, 7),
 (31826044, 479107123, 8),
 (62200017, 510210157, 9),
 (32540326, 608628049, 10);

/*_____________________________PESSOAJURIDICA______________________________*/

 insert into PessoaJuridica (cnpj, razaosocial, idcliente_spk) values
(82846901343573, 'Teklist', 11),
 (67679279091259, 'Dynazzy', 12),
 (34341917482154, 'Jaxspan', 13),
 (37551524565334, 'Fliptune', 14),
 (82834446973393, 'Gabcube', 15),
 (32661894370093, 'Skipstorm', 16),
 (83755403712886, 'Quatz', 17),
 (56148392097914, 'Vinte', 18),
 (65386468514319, 'Fivechat', 19),
 (23351464466687, 'Myworks', 20);

/*_____________________________COBRE_____________________________________*/

insert into Cobre (idPedido_SPK, idAcidente_SPK, idSeguradora_SPK)
values
(1, 2, 4),
(3, 1, 3),
(4, 3, 4);

/*_____________________________DESPACHA_____________________________________*/

 insert into Despacha (datarecebimento, datadespacho, idpedido_fk, idunidade_fk) values
 ('2016-09-12', '2019-01-03', 1, 9),
 ('2017-05-13', '2018-12-06', 13, 9),
 ('2018-05-19', '2019-02-21', 19, 1),
 ('2016-11-09', '2019-04-23', 9, 6),
 ('2017-06-18', '2019-04-30', 19, 7),
 ('2017-01-30', '2019-01-17', 16, 5),
 ('2017-05-31', '2019-05-15', 1, 1),
 ('2018-02-06', '2018-12-05', 8, 9),
 ('2018-06-07', '2018-06-28', 4, 3),
 ('2018-03-24', '2019-03-03', 11, 4),
 ('2017-04-06', '2018-07-01', 10, 2),
 ('2017-01-16', '2018-09-23', 12, 4),
 ('2018-01-28', '2019-02-23', 4, 10),
 ('2018-04-18', '2018-12-05', 14, 6),
 ('2018-02-09', '2018-12-15', 17, 6);

/*_____________________________ESTOQUISTA_____________________________________*/

insert into Estoquista(idFuncionario_SPK) values 
(1),
(2),
(3),
(4);

/*_____________________________ESTOCA_____________________________________*/

 insert into Estoca (dataestoc, idlote_spk, idcontainer_spk, idestoquista_spk) values
 ('2015-10-28 02:45:31', 1, 7, 3),
 ('2016-12-17 10:12:01', 6, 9, 3),
 ('2015-10-29 17:46:55', 5, 1, 3),
 ('2015-06-17 20:31:05', 1, 2, 4),
 ('2017-01-28 14:34:54', 1, 2, 3),
 ('2018-03-20 01:11:44', 6, 10, 2),
 ('2016-04-24 13:35:51', 1, 2, 3),
 ('2015-07-19 18:28:40', 4, 8, 4),
 ('2016-01-13 17:46:32', 4, 10, 2),
 ('2016-11-23 16:00:25', 5, 3, 1);

 /*_____________________________MOTORISTA_____________________________________*/

insert into Motorista(emViagem, idFuncionario_SPK) values
(false,5),
(true,6),
(false,7),
(false,8),
(true,9),
(true,10),
(true,11),
(true,12),
(false,13),
(true,14);
 /*_____________________________CAMINHONEIRO_____________________________________*/

insert into Caminhoneiro(cnh, idFuncionario_SPK) VALUES
(12345678912,5),
(12345678913,6),
(12345678914,7),
(12345678915,8);

 /*_____________________________CAPITAO_____________________________________*/

insert into Capitao(ARRAIS, idFuncionario_SPK) values
(0987654321,9),
(0987654322,10),
(0987654323,11);

 /*_____________________________CAPITAO_____________________________________*/
 
insert into Maquinista(autorizacao, idFuncionario_SPK) values
(01234567899876543210,12),
(01234567899876543211, 13),
(01234567899876543212, 14);