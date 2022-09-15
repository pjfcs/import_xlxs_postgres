#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER usergestor WITH PASSWORD '1234';
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
    CREATE TABLE fiplan.programa(
          id_programa                         serial
        , id_subfuncao                        bigint
        , codigo_do_programa                  varchar
        , nome_do_programa                    varchar
        , sigla_do_programa                   varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id_programa )
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
          id_fiplan61                         serial
        , exercicio                           varchar
        , codigo_do_poder                     varchar
        , nome_do_poder                       varchar
        , codigo_do_orgao                     varchar
        , nome_do_orgao                       varchar
        , sigla_do_orgao                      varchar
        , codigo_da_uo                        varchar
        , nome_da_uo                          varchar
        , sigla_da_uo                         varchar
        , codigo_da_ug                        varchar
        , nome_da_ug                          varchar
        , sigla_da_ug                         varchar
        , codigo_do_orgao_de_destino          varchar
        , nome_do_orgao_de_destino            varchar
        , sigla_do_orgao_de_destino           varchar
        , codigo_da_uo_destino                varchar
        , nome_da_uo_destino                  varchar
        , sigla_da_uo_destino                 varchar
        , codigo_da_ug_destino                varchar
        , nome_da_ug_destino                  varchar
        , sigla_da_ug_destino                 varchar
        , codigo_da_usp                       varchar
        , nome_da_usp                         varchar
        , sigla_da_usp                        varchar
        , tipo_da_acao                        varchar
        , codigo_da_acao                      varchar
        , nome_da_acao                        varchar
        , sigla_da_acao                       varchar
        , objetivo_da_acao                    varchar
        , classificacao_da_acao               varchar
        , detalhamento_da_acao                varchar
        , indicativo_de_acao_prioritaria      varchar
        , codigo_da_prioridade_de_governo     varchar
        , prioridade                          varchar
        , esfera_orcamentaria                 varchar
        , codigo_da_funcao                    varchar
        , nome_da_funcao                      varchar
        , sigla_da_funcao                     varchar
        , codigo_da_subfuncao                 varchar
        , nome_da_subfuncao                   varchar
        , sigla_da_subfuncao                  varchar
        , codigo_do_programa                  varchar
        , nome_do_programa                    varchar
        , sigla_do_programa                   varchar
        , codigo_do_produto                   varchar
        , nome_do_produto                     varchar
        , sigla_do_produto                    varchar
        , codigo_da_unidade_de_medida         varchar
        , nome_da_unidade_de_medida           varchar
        , sigla_da_unidade_de_medida          varchar
        , codigo_da_regiao                    varchar
        , nome_da_regiao                      varchar
        , codigo_da_destinacao                varchar
        , codigo_do_identificador_de_uso      varchar
        , codigo_da_fonte                     varchar
        , nome_da_fonte                       varchar
        , sigla_da_fonte                      varchar
        , codigo_da_subfonte                  varchar
        , nome_da_subfonte                    varchar
        , sigla_da_subfonte                   varchar
        , codigo_da_natureza                  varchar
        , nome__da_natureza                   varchar
        , sigla_da_natureza                   varchar
        , codigo_da_categoria                 varchar
        , nome__da_categoria_economica        varchar
        , codigo_do_grupo                     varchar
        , nome_do_grupo                       varchar
        , sigla_do_grupo                      varchar
        , codigo_da_modalidade                varchar
        , nome_da_modalidade                  varchar
        , sigla_da_modalidade                 varchar
        , codigo_do_elemento                  varchar
        , nome_do_elemento                    varchar
        , sigla_do_elemento                   varchar
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
        , data_de_extracao_de_dados           varchar
        , hora_de_extracao_de_dados           varchar 
        , dt_cadastro                         timestamp default now()
        , primary key ( id_fiplan61 )
    );    
EOSQL