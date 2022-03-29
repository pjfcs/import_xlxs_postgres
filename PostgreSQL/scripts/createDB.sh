#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER userGestor WITH PASSWORD '1234';
    CREATE DATABASE db_Fiplan OWNER userGestor;
    \c db_fiplan;
    CREATE SCHEMA fiplan;
    CREATE TABLE fiplan.poder(
          id_poder                            serial
        , codigo_do_poder                     varchar
        , nome_do_poder                       varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.orgao(
          id_orgao                            serial
        , codigo_do_orgao                     varchar
        , nome_do_orgao                       varchar
        , sigla_do_orgao                      varchar
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.uo(
          id_uo                               serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.ug(
          id_ug                               serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.usp(
          id_usp                              serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.acao(
          id_acao                             serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.prioridade_de_governo(
          id_prioridade_de_governo            serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.funcao(
          id_funcao                           serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.subfuncao(
          id_subfuncao                        serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.programa(
          id_programa                         serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.produto(
          id_produto                          serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.unidade_de_medida(
          id_unidade_de_medida                serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.regiao(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.destinacao(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.identificador_de_uso(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.fonte(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.subfonte(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.natureza(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.categoria_economica(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.grupo(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.modalidade(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.elemento(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )
    CREATE TABLE fiplan.tipo_de_gasto(
          id                                  serial
        , 
        , dt_cadastro                         timestamp default now()
        , primary key ( id )
    )

    CREATE TABLE fiplan.fiplan61 (
          id                                  serial
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
    )
EOSQL