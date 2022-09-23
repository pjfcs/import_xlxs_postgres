#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    DROP DATABASE IF EXISTS db_fiplan;
    CREATE DATABASE db_fiplan OWNER usergestor;
EOSQL
psql -v ON_ERROR_STOP=1 --username usergestor --dbname db_fiplan <<-EOSQL    
    CREATE SCHEMA fiplan;
    CREATE TABLE fiplan.poder(
          id_poder                            serial
        , codigo_do_poder                     varchar
        , nome_do_poder                       varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_poder )
    );
CREATE TABLE fiplan.orgao(
          id_orgao                            serial
        , id_poder                            bigint
        , codigo_do_orgao                     varchar
        , nome_do_orgao                       varchar
        , sigla_do_orgao                      varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_orgao )
    );
    CREATE TABLE fiplan.uo(
          id_uo                               serial
        , id_orgao                            bigint
        , codigo_da_uo                        varchar
        , nome_da_uo                          varchar
        , sigla_da_uo                         varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_uo )
    );
    CREATE TABLE fiplan.ug(
          id_ug                               serial
        , id_orgao                            bigint
        , codigo_da_ug                        varchar
        , nome_da_ug                          varchar
        , sigla_da_ug                         varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_ug )
    );
    CREATE TABLE fiplan.usp(
          id_usp                              serial
        , id_orgao                            bigint
        , codigo_da_usp                       varchar
        , nome_da_usp                         varchar
        , sigla_da_usp                        varchar        
        , dt_cadastro                         timestamp default now()
        , primary key ( id_usp )
    );
    CREATE TABLE fiplan.programa(
          id_programa                         serial
        , id_subfuncao                        bigint
        , codigo_do_programa                  varchar
        , nome_do_programa                    varchar
        , sigla_do_programa                   varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_programa )
    );    
    CREATE TABLE fiplan.acao(
          id_acao                             serial
        , id_usp                              serial
        , codigo_da_acao                      varchar
        , nome_da_acao                        varchar
        , sigla_da_acao                       varchar
        , objetivo_da_acao                    varchar
        , classificacao_da_acao               varchar
        , detalhamento_da_acao                varchar
        , indicativo_de_acao_prioritaria      varchar
        , tipo_da_acao                        varchar
        , esfera_orcamentaria                 varchar        
        , dt_cadastro                         timestamp default now()
        , primary key ( id_acao )
    );
    CREATE TABLE fiplan.fonte(
          id_fonte                            serial
        , codigo_da_destinacao                varchar
        , codigo_do_identificador_de_uso      varchar
        , codigo_da_fonte                     varchar
        , nome_da_fonte                       varchar
        , sigla_da_fonte                      varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_fonte )
    );    
    CREATE TABLE fiplan.prioridade_de_governo(
          id_prioridade_de_governo            serial
        , codigo_da_prioridade_de_governo     varchar
        , prioridade_de_governo               varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_prioridade_de_governo )
    );
    CREATE TABLE fiplan.funcao(
          id_funcao                           serial
        , codigo_da_funcao                    varchar
        , nome_da_funcao                      varchar
        , sigla_da_funcao                     varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_funcao )
    );
    CREATE TABLE fiplan.subfuncao(
          id_subfuncao                        serial
        , id_funcao                           bigint
        , codigo_da_subfuncao                 varchar
        , nome_da_subfuncao                   varchar
        , sigla_da_subfuncao                  varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_subfuncao )
    );

    CREATE TABLE fiplan.produto(
          id_produto                          serial
        , id_programa                         bigint
        , codigo_do_produto                   varchar
        , nome_do_produto                     varchar
        , sigla_do_produto                    varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_produto )
    );
    CREATE TABLE fiplan.unidade_de_medida(
          id_unidade_de_medida                serial
        , codigo_da_unidade_de_medida         varchar
        , nome_da_unidade_de_medida           varchar
        , sigla_da_unidade_de_medida          varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_unidade_de_medida )
    );
    CREATE TABLE fiplan.regiao(
          id_regiao                           serial
        , codigo_da_regiao                    varchar
        , nome_da_regiao                      varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_regiao )
    );

    CREATE TABLE fiplan.subfonte(
          id_subfonte                         serial
        , codigo_da_subfonte                  varchar
        , nome_da_subfonte                    varchar
        , sigla_da_subfonte                   varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_subfonte )
    );
    CREATE TABLE fiplan.natureza(
          id_natureza                         serial
        , codigo_da_natureza                  varchar
        , nome_da_natureza                    varchar
        , sigla_da_natureza                   varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_natureza )
    );
    CREATE TABLE fiplan.categoria_economica(
          id_categoria_economica              serial
        , codigo_da_categoria_economica       varchar
        , nome_da_categoria_economica         varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_categoria_economica )
    );
    CREATE TABLE fiplan.grupo(
          id_grupo                            serial
        , codigo_do_grupo                     varchar
        , nome_do_grupo                       varchar
        , sigla_do_grupo                      varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_grupo )
    );
    CREATE TABLE fiplan.modalidade(
          id_modalidade                       serial
        , codigo_da_modalidade                varchar
        , nome_da_modalidade                  varchar
        , sigla_da_modalidade                 varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_modalidade )
    );
    CREATE TABLE fiplan.elemento(
          id_elemento                         serial
        , codigo_do_elemento                  varchar
        , nome_do_elemento                    varchar
        , sigla_do_elemento                   varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_elemento )
    );
    CREATE TABLE fiplan.tipo_de_gasto(
          id_tipo_de_gasto                    serial
        , codigo_do_tipo_de_gasto             varchar
        , descricao_do_tipo_de_gasto          varchar
        , valor_orcado_inicial                numeric
        , valor_suplementado                  numeric
        , valor_anulado                       numeric
        , valor_atual                         numeric
        , valor_descentralizado               numeric
        , valor_bloqueado                     numeric
        , valor_contingenciado                numeric
        , valor_ped                           numeric
        , valor_empenhado                     numeric
        , valor_liquidado                     numeric
        , valor_pago                          numeric
        , dthr_extracao_dados                 timestamp default now()
        , dt_cadastro                         timestamp default now()
        , primary key ( id_tipo_de_gasto )
    );
    CREATE TABLE fiplan.fiplan61 (
          id_fiplan61                              serial
        , exercicio                                varchar
        , codigo_do_poder                          varchar
        , nome_do_poder                            varchar
        , codigo_do_orgao                          varchar
        , nome_do_orgao                            varchar
        , sigla_do_orgao                           varchar
        , codigo_da_uo                             varchar
        , nome_da_uo                               varchar
        , sigla_da_uo                              varchar
        , codigo_da_ug                             varchar
        , nome_da_ug                               varchar
        , sigla_da_ug                              varchar
        , codigo_do_orgao_de_destino               varchar
        , nome_do_orgao_de_destino                 varchar
        , sigla_do_orgao_de_destino                varchar
        , codigo_da_uo_destino                     varchar
        , nome_da_uo_destino                       varchar
        , sigla_da_uo_destino                      varchar
        , codigo_da_ug_destino                     varchar
        , nome_da_ug_destino                       varchar
        , sigla_da_ug_destino                      varchar
        , codigo_da_usp                            varchar
        , nome_da_usp                              varchar
        , sigla_da_usp                             varchar
        , tipo_da_acao                             varchar
        , codigo_da_acao                           varchar
        , nome_da_acao                             varchar
        , sigla_da_acao                            varchar
        , objetivo_da_acao                         varchar
        , classificacao_da_acao                    varchar
        , detalhamento_da_acao                     varchar
        , indicativo_de_acao_prioritaria           varchar
        , codigo_da_prioridade_de_governo          varchar
        , prioridade                               varchar
        , esfera_orcamentaria                      varchar
        , codigo_da_funcao                         varchar
        , nome_da_funcao                           varchar
        , sigla_da_funcao                          varchar
        , codigo_da_subfuncao                      varchar
        , nome_da_subfuncao                        varchar
        , sigla_da_subfuncao                       varchar
        , codigo_do_programa                       varchar
        , nome_do_programa                         varchar
        , sigla_do_programa                        varchar
        , codigo_do_produto                        varchar
        , nome_do_produto                          varchar
        , sigla_do_produto                         varchar
        , codigo_da_unidade_de_medida              varchar
        , nome_da_unidade_de_medida                varchar
        , sigla_da_unidade_de_medida               varchar
        , codigo_da_regiao                         varchar
        , nome_da_regiao                           varchar
        , codigo_da_destinacao                     varchar
        , codigo_do_identificador_de_exercicio     varchar
        , codigo_da_ftfe                           varchar
        , nome_da_ftfe                             varchar
        , nome_resumido_da_ftfe                    varchar
        , codigo_do_identificador_de_uso           varchar
        , codigo_da_fonte                          varchar
        , nome_da_fonte                            varchar
        , sigla_da_fonte                           varchar
        , codigo_do_tiac                           varchar
        , nome_do_tiac                             varchar
        , codigo_do_diac                           varchar
        , nome_do_diac                             varchar
        , codigo_do_ia                             varchar
        , nome_do_ia                               varchar
        , codigo_da_subfonte                       varchar
        , nome_da_subfonte                         varchar
        , sigla_da_subfonte                        varchar
        , codigo_da_natureza                       varchar
        , nome__da_natureza                        varchar
        , sigla_da_natureza                        varchar
        , codigo_da_categoria                      varchar
        , nome__da_categoria_economica             varchar
        , codigo_do_grupo                          varchar
        , nome_do_grupo                            varchar
        , sigla_do_grupo                           varchar
        , codigo_da_modalidade                     varchar
        , nome_da_modalidade                       varchar
        , sigla_da_modalidade                      varchar
        , codigo_do_elemento                       varchar
        , nome_do_elemento                         varchar
        , sigla_do_elemento                        varchar
        , codigo_do_tipo_de_gasto                  varchar
        , descricao_do_tipo_de_gasto               varchar
        , valor_orcado_inicial                     numeric
        , valor_suplementado                       numeric
        , valor_anulado                            numeric
        , valor_atual                              numeric
        , valor_descentralizado                    numeric
        , valor_bloqueado                          numeric
        , valor_contingenciado                     numeric
        , valor_ped                                numeric
        , valor_empenhado                          numeric
        , valor_liquidado                          numeric
        , valor_pago                               numeric
        , data_de_extracao_de_dados                varchar
        , hora_de_extracao_de_dados                varchar 
        , dt_cadastro                              timestamp default now()
        , primary key ( id_fiplan61 )     
    );

    comment on table fiplan.fiplan61 
    is 'Tabela para receber os dados da planilha61 do fiplan, exportada pela APG.';

        comment on column fiplan.fiplan61.id_fiplan61                          
    is 'Identificador unívoco do registro. Surrogate key.';
    comment on column fiplan.fiplan61.exercicio                            
    is 'Ano de referência.';
    comment on column fiplan.fiplan61.codigo_do_poder                      
    is 'Código do Poder.';
    comment on column fiplan.fiplan61.nome_do_poder                        
    is 'Nome do Poder.';
    comment on column fiplan.fiplan61.codigo_do_orgao                      
    is 'Código do Órgão.';
    comment on column fiplan.fiplan61.nome_do_orgao                        
    is 'Nome do Órgão.';
    comment on column fiplan.fiplan61.sigla_do_orgao                       
    is 'Sigla do Órgão.';
    comment on column fiplan.fiplan61.codigo_da_uo                         
    is 'Código da Unidade Orçamentária.';
    comment on column fiplan.fiplan61.nome_da_uo                           
    is 'Nome da Unidade Orçamentária.';
    comment on column fiplan.fiplan61.sigla_da_uo                          
    is 'Sigla da Unidade Orçamentária.';
    comment on column fiplan.fiplan61.codigo_da_ug                         
    is 'Código da Unidade Gestora.';
    comment on column fiplan.fiplan61.nome_da_ug                           
    is 'Nome da Unidade Gestora.';
    comment on column fiplan.fiplan61.sigla_da_ug                          
    is 'Sigla da Unidade Gestora.';
    comment on column fiplan.fiplan61.codigo_do_orgao_de_destino           
    is 'Código do Órgão de Destino.';
    comment on column fiplan.fiplan61.nome_do_orgao_de_destino             
    is 'Nome do Órgão de Destino.';
    comment on column fiplan.fiplan61.sigla_do_orgao_de_destino            
    is 'Sigla do Órgão de Destino.';
    comment on column fiplan.fiplan61.codigo_da_uo_destino                 
    is 'Código da Unidade Orçamentária de destino.';
    comment on column fiplan.fiplan61.nome_da_uo_destino                   
    is 'Nome da Unidade Orçamentária de destino.';
    comment on column fiplan.fiplan61.sigla_da_uo_destino                  
    is 'Sigla da Unidade Orçamentária de destino.';
    comment on column fiplan.fiplan61.codigo_da_ug_destino                 
    is 'Código da Unidade Gestora de destino.';
    comment on column fiplan.fiplan61.nome_da_ug_destino                   
    is 'Nome da Unidade Gestora de destino.';
    comment on column fiplan.fiplan61.sigla_da_ug_destino                  
    is 'Sigla da Unidade Gestora de destino.';
    comment on column fiplan.fiplan61.codigo_da_usp                        
    is 'Código da Unidade Setorial de Planejamento.';
    comment on column fiplan.fiplan61.nome_da_usp                          
    is 'Nome da Unidade Setorial de Planejamento.';
    comment on column fiplan.fiplan61.sigla_da_usp                         
    is 'Sigla da Unidade Setorial de Planejamento.';
    comment on column fiplan.fiplan61.tipo_da_acao                         
    is 'Tipo da Ação Orçamentária.';
    comment on column fiplan.fiplan61.codigo_da_acao                       
    is 'Código da Ação Orçamentária.';
    comment on column fiplan.fiplan61.nome_da_acao                         
    is 'Nome da Ação Orçamentária.';
    comment on column fiplan.fiplan61.sigla_da_acao                        
    is 'Nome resumido da Ação Orçamentária.';
    comment on column fiplan.fiplan61.objetivo_da_acao                     
    is 'Objetivo da Ação Orçamentária.';
    comment on column fiplan.fiplan61.classificacao_da_acao                
    is 'Classificação da Ação Orçamentária.';
    comment on column fiplan.fiplan61.detalhamento_da_acao                 
    is 'Detalhamento da Ação Orçamentária.';
    comment on column fiplan.fiplan61.indicativo_de_acao_prioritaria       
    is 'Indicativo de Ação Prioritária.';
    comment on column fiplan.fiplan61.codigo_da_prioridade_de_governo      
    is 'Código da Prioridade de governo.';
    comment on column fiplan.fiplan61.prioridade                           
    is 'Prioridade de governo.';
    comment on column fiplan.fiplan61.esfera_orcamentaria                  
    is 'Esfera Orçamentária.';
    comment on column fiplan.fiplan61.codigo_da_funcao                     
    is 'Código da Função de governo.';
    comment on column fiplan.fiplan61.nome_da_funcao                       
    is 'Nome da Função de governo.';
    comment on column fiplan.fiplan61.sigla_da_funcao                      
    is 'Nome Resumido da Função de governo.';
    comment on column fiplan.fiplan61.codigo_da_subfuncao                  
    is 'Código da Subfunção.';
    comment on column fiplan.fiplan61.nome_da_subfuncao                    
    is 'Nome da Subfunção.';
    comment on column fiplan.fiplan61.sigla_da_subfuncao                   
    is 'Nome Resumido da Subfunção.';
    comment on column fiplan.fiplan61.codigo_do_programa                   
    is 'Código do Programa.';
    comment on column fiplan.fiplan61.nome_do_programa                     
    is 'Nome do Programa.';
    comment on column fiplan.fiplan61.sigla_do_programa                    
    is 'Nome Resumido do Programa.';
    comment on column fiplan.fiplan61.codigo_do_produto                    
    is 'Código do Produto.';
    comment on column fiplan.fiplan61.nome_do_produto                      
    is 'Nome do Produto.';
    comment on column fiplan.fiplan61.sigla_do_produto                     
    is 'Nome Resumido do Produto.';
    comment on column fiplan.fiplan61.codigo_da_unidade_de_medida          
    is 'Código da Unidade de Medida.';
    comment on column fiplan.fiplan61.nome_da_unidade_de_medida            
    is 'Nome da Unidade de Medida.';
    comment on column fiplan.fiplan61.sigla_da_unidade_de_medida           
    is 'Sigla da Unidade de Medida.';
    comment on column fiplan.fiplan61.codigo_da_regiao                     
    is 'Código da Região.';
    comment on column fiplan.fiplan61.nome_da_regiao                       
    is 'Nome da Região.';
    comment on column fiplan.fiplan61.codigo_da_destinacao                 
    is 'Código da Destinação.';
    comment on column fiplan.fiplan61.codigo_do_identificador_de_exercicio 
    is 'Código do Identificador de Exercício.';
    comment on column fiplan.fiplan61.codigo_da_ftfe                       
    is 'Código da Fonte de Recurso Federação.';
    comment on column fiplan.fiplan61.nome_da_ftfe                         
    is 'Nome da Fonte de Recurso Federação.';
    comment on column fiplan.fiplan61.nome_resumido_da_ftfe                
    is 'Nome resumido da Fonte de Recurso Federação.';
    comment on column fiplan.fiplan61.codigo_do_identificador_de_uso       
    is 'Código do Identificador de Uso.';
    comment on column fiplan.fiplan61.codigo_da_fonte                      
    is 'Código da Fonte de Recurso Estadual.';
    comment on column fiplan.fiplan61.nome_da_fonte                        
    is 'Nome da Fonte de Recurso Estadual.';
    comment on column fiplan.fiplan61.sigla_da_fonte                       
    is 'Nome resumido da Fonte de Recurso Estadual.';
    comment on column fiplan.fiplan61.codigo_do_tiac                       
    is 'Código da Subfonte de recurso.';
    comment on column fiplan.fiplan61.nome_do_tiac                         
    is 'Nome da Subfonte de recurso.';
    comment on column fiplan.fiplan61.codigo_do_diac                       
    is 'Nome resumido da Subfonte de recurso.';
    comment on column fiplan.fiplan61.nome_do_diac                         
    is 'Código do Tipo de Identificador de Acompanhamento.';
    comment on column fiplan.fiplan61.codigo_do_ia                         
    is 'Nome do Tipo de Identificador de Acompanhamento.';
    comment on column fiplan.fiplan61.nome_do_ia                           
    is 'Código do Detalhamento do Identificador de Acompanhamento.';
    comment on column fiplan.fiplan61.codigo_da_subfonte                   
    is 'Nome do Detalhamento do Identificador de Acompanhamento.';
    comment on column fiplan.fiplan61.nome_da_subfonte                     
    is 'Código da Informação Adicional.';
    comment on column fiplan.fiplan61.sigla_da_subfonte                    
    is 'Nome da Informação Adicional.';
    comment on column fiplan.fiplan61.codigo_da_natureza                   
    is 'Código da Natureza da despesa.';
    comment on column fiplan.fiplan61.nome__da_natureza                    
    is 'Nome da Natureza da despesa.';
    comment on column fiplan.fiplan61.sigla_da_natureza                    
    is 'Nome resumido da Natureza da despesa.';
    comment on column fiplan.fiplan61.codigo_da_categoria                  
    is 'Código da Categoria Econômica.';
    comment on column fiplan.fiplan61.nome__da_categoria_economica         
    is 'Nome  da Categoria Econômica.';
    comment on column fiplan.fiplan61.codigo_do_grupo                      
    is 'Código do Grupo de despesa.';
    comment on column fiplan.fiplan61.nome_do_grupo                        
    is 'Nome do Grupo de despesa.';
    comment on column fiplan.fiplan61.sigla_do_grupo                       
    is 'Nome resumido do Grupo de despesa.';
    comment on column fiplan.fiplan61.codigo_da_modalidade                 
    is 'Código da Modalidade de aplicação.';
    comment on column fiplan.fiplan61.nome_da_modalidade                   
    is 'Nome da Modalidade de aplicação.';
    comment on column fiplan.fiplan61.sigla_da_modalidade                  
    is 'Nome resumido da Modalidade de aplicação.';
    comment on column fiplan.fiplan61.codigo_do_elemento                   
    is 'Código do Elemento de despesa.';
    comment on column fiplan.fiplan61.nome_do_elemento                     
    is 'Nome do Elemento de despesa.';
    comment on column fiplan.fiplan61.sigla_do_elemento                    
    is 'Nome resumido do Elemento de despesa.';
    comment on column fiplan.fiplan61.codigo_do_tipo_de_gasto              
    is 'Código do Tipo de Gasto.';
    comment on column fiplan.fiplan61.descricao_do_tipo_de_gasto           
    is 'Descrição do Tipo de Gasto.';
    comment on column fiplan.fiplan61.valor_orcado_inicial                 
    is 'Valor Orçado Inicial ( LOA ).';
    comment on column fiplan.fiplan61.valor_suplementado                   
    is 'Valor Suplementado.';
    comment on column fiplan.fiplan61.valor_anulado                        
    is 'Valor Anulado.';
    comment on column fiplan.fiplan61.valor_atual                          
    is 'Valor Atual .';
    comment on column fiplan.fiplan61.valor_descentralizado                
    is 'Valor Descentralizado.';
    comment on column fiplan.fiplan61.valor_bloqueado                      
    is 'Valor Bloqueado.';
    comment on column fiplan.fiplan61.valor_contingenciado                 
    is 'Valor Contingenciado.';
    comment on column fiplan.fiplan61.valor_ped                            
    is 'Valor PED - Pedido de Empenho.';
    comment on column fiplan.fiplan61.valor_empenhado                      
    is 'Valor Empenhado.';
    comment on column fiplan.fiplan61.valor_liquidado                      
    is 'Valor Liquidado.';
    comment on column fiplan.fiplan61.valor_pago                           
    is 'Valor Pago.';
    comment on column fiplan.fiplan61.data_de_extracao_de_dados            
    is 'Data de Extração de Dados.';
    comment on column fiplan.fiplan61.hora_de_extracao_de_dados            
    is 'Hora de Extração de Dados.';
    comment on column fiplan.fiplan61.dt_cadastro                          
    is 'Data e hora de inserção do registro na tabela fiplan.fiplan61.';
EOSQL