package main

import (
    "fmt"
	"os"
	"github.com/BurntSushi/toml"
	//"io/ioutil"
    "strings"
    "github.com/xuri/excelize/v2"
    "database/sql"
    _ "github.com/lib/pq"
/*
	"bytes"
	"encoding/json"
	"fmt"	
	"path/filepath"
	"regexp"
	"strings"
	"testing"	
	"github.com/BurntSushi/toml/internal/tag"
	tomltest "github.com/BurntSushi/toml/internal/toml-test"
*/	    
)

type Config struct {
    LinhaInicioTabela       int    `toml:"linha_inicio_tabela"`
    HostPostgreSQL          string `toml:"host_postgresql"`
    PortPostgreSQL          string `toml:"port_postgresql"`
    DatabasePostgreSQL      string `toml:"database_postgresql"`
	UserPostgreSQL          string `toml:"user_postgresql"`
	PasswordUserPostgreSQL  string `toml:"password_user_postgresql"`
    ArquivoExcel            string `toml:"arquivo_excel"`
    PlanilhaExcel           string `toml:"planilha_excel"`
}

var conf Config

func init(){
    data, err := os.ReadFile("config")
    if err != nil {
        panic(err)
    }
    
    if _, err := toml.Decode(string(data), &conf); err != nil {
         panic(err)
    }
}

func getLink() (*sql.DB) {
    conStr := "host="      + conf.HostPostgreSQL
    conStr += " port="     + conf.PortPostgreSQL
    conStr += " user="     + conf.UserPostgreSQL
    conStr += " password=" + conf.PasswordUserPostgreSQL
    conStr += " dbname="   + conf.DatabasePostgreSQL
    conStr += " sslmode=disable"

    //fmt.Println(conStr)
    // db, err := sql.Open("postgres", "host=localhost port=5432 user=aprenda password=golang dbname=blog sslmode=disable")
    
    db, err := sql.Open("postgres", conStr)

    if err != nil {
        panic(err)
    }

    //err = db.Ping()

    return db
}

func getExcel(){    
	excelFile, err := excelize.OpenFile(conf.ArquivoExcel)
    if err != nil {
        fmt.Println(err)
        return
    }

    defer func() {
        if err := excelFile.Close(); err != nil {
            fmt.Println(err)
        }
    }()
	
    sql := `insert into fiplan.fiplan61 (
      exercicio, codigo_do_poder, nome_do_poder, codigo_do_orgao, nome_do_orgao, sigla_do_orgao, codigo_da_uo, nome_da_uo
    , sigla_da_uo, codigo_da_ug, nome_da_ug, sigla_da_ug, codigo_do_orgao_de_destino, nome_do_orgao_de_destino
    , sigla_do_orgao_de_destino, codigo_da_uo_destino, nome_da_uo_destino, sigla_da_uo_destino, codigo_da_ug_destino
    , nome_da_ug_destino, sigla_da_ug_destino, codigo_da_usp, nome_da_usp, sigla_da_usp, tipo_da_acao, codigo_da_acao
    , nome_da_acao, sigla_da_acao, objetivo_da_acao, classificacao_da_acao, detalhamento_da_acao, indicativo_de_acao_prioritaria
    , codigo_da_prioridade_de_governo, prioridade, esfera_orcamentaria, codigo_da_funcao, nome_da_funcao, sigla_da_funcao
    , codigo_da_subfuncao, nome_da_subfuncao, sigla_da_subfuncao, codigo_do_programa, nome_do_programa, sigla_do_programa
    , codigo_do_produto, nome_do_produto, sigla_do_produto, codigo_da_unidade_de_medida, nome_da_unidade_de_medida
    , sigla_da_unidade_de_medida, codigo_da_regiao, nome_da_regiao, codigo_da_destinacao, codigo_do_identificador_de_uso
    , codigo_da_fonte, nome_da_fonte, sigla_da_fonte, codigo_da_subfonte, nome_da_subfonte, sigla_da_subfonte, codigo_da_natureza
    , nome__da_natureza, sigla_da_natureza, codigo_da_categoria, nome__da_categoria_economica, codigo_do_grupo, nome_do_grupo
    , sigla_do_grupo, codigo_da_modalidade, nome_da_modalidade, sigla_da_modalidade, codigo_do_elemento, nome_do_elemento
    , sigla_do_elemento, codigo_do_tipo_de_gasto, descricao_do_tipo_de_gasto, valor_orcado_inicial, valor_suplementado
    , valor_anulado, valor_atual, valor_descentralizado, valor_bloqueado, valor_contingenciado, valor_ped, valor_empenhado
    , valor_liquidado, valor_pago, data_de_extracao_de_dados, hora_de_extracao_de_dados
    ) values 
    `
    
    rows, err := excelFile.GetRows(conf.PlanilhaExcel)
    if err != nil {
        fmt.Println(err)
        return
    }

    for _, row := range rows[conf.LinhaInicioTabela:] {
        sql += "( "
        for _, cell := range row{
            sql += "'" + cell + "', "
        }
        sql = strings.TrimSuffix(sql, ", ") + " ), "
    }
    sql = strings.TrimSuffix(sql, ", ")
    fmt.Println(sql);

    link := getLink()

    _, err = link.Query(sql)

    switch err {
        //case sql.ErrNoRows:
        //    fmt.Println("No rows were returned!")
        default:
            fmt.Println("Unable to scan the row. %v", err)
    }    
/**/
}

func main() {    
    fmt.Println("")
    fmt.Println("Iniciando importador da planilha 61 do fiplan.")
/*    
    fmt.Println("")
    fmt.Printf("linhaInicioTabela: %d\n", conf.LinhaInicioTabela)
    fmt.Printf("hostPostgreSQL: %s\n", conf.HostPostgreSQL)
    fmt.Printf("portPostgreSQL: %s\n", conf.PortPostgreSQL)
    fmt.Printf("databasePostgreSQL: %s\n", conf.DatabasePostgreSQL)
    fmt.Printf("passwordUserPostgreSQL: %s\n", conf.PasswordUserPostgreSQL)
    fmt.Println("")
/**/    
    fmt.Println("")
/*    
    if link != nil {
        fmt.Println("Conectado ao Postgres.")
    }else{
        fmt.Println("Não conectado!")
    }
/**/    
    getExcel()
    fmt.Println("")
}