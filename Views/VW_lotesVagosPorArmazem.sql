/*Descrição: mostra todos lotes que estão disponiveis, organizados de acordo com as Unidades e Armazens*/

/*DROP VIEW VW_lotesVagosPorUnidade;*/
CREATE VIEW VW_lotesVagosPorUnidade AS select r.idUnidade_PK,r.idArmazem_PK,
        r.idLote_PK,r.setor,r.posicao from (select l.idLote_PK,a.idArmazem_PK,
            u.idUnidade_PK,l.setor,l.posicao FROM Lote l,Armazem a,Unidade u where 
                l.idArmazem_FK = a.idArmazem_PK and a.idUnidade_FK = u.idUnidade_PK) 
                    as r where r.idLote_PK not in (select l.idLote_PK from Lote l inner join
                         Container c on l.idLote_PK = c.idLote_FK) 
                            ORDER BY r.idUnidade_PK,r.idArmazem_PK;