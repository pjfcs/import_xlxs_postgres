package main

import (
    "fmt"
	"os"
	"github.com/BurntSushi/toml"
	//"io/ioutil"
    //"strings"
    //"github.com/xuri/excelize/v2"
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
    linhaInicioTabela int `toml:"linhaInicioTabela"`
    hostPostgreSQL    string `toml:"hostPostgreSQL"`
    dbPostgreSQL      string `toml:"dbPostgreSQL"`
	userPostgreSQL    string `toml:"userPostgreSQL"`
	pwdUserPostgreSQL string `toml:"pwdUserPostgreSQL"`
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

func main() {
	init
    fmt.Printf("linhaInicioTabela: %s\n", conf.linhaInicioTabela)
    fmt.Printf("hostPostgreSQL: %s\n", conf.hostPostgreSQL)
    fmt.Printf("dbPostgreSQL: %s\n", conf.dbPostgreSQL)
    fmt.Printf("pwdUserPostgreSQL: %s\n", conf.pwdUserPostgreSQL)
}

/*

func main{
	fiplan := "excel/PLAN 61_2022.xlsx"
	f, err := excelize.OpenFile(fiplan)
    if err != nil {
        fmt.Println(err)
        return
    }

    defer func() {
        if err := f.Close(); err != nil {
            fmt.Println(err)
        }
    }()
	
    // Get value from cell by given worksheet name and axis.
    cell, err := f.GetCellValue("Sheet1", "B2")
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Println(cell)
    // Get all the rows in the Sheet1.
    rows, err := f.GetRows("Sheet1")
    if err != nil {
        fmt.Println(err)
        return
    }
    for _, row := range rows {
        for _, colCell := range row {
            fmt.Print(colCell, "\t")
        }
        fmt.Println()
    }

}

/*
package main
import (
"fm"
"registro"

"github.com/xuri/excelize/v2"
)


func main(){
	Arquivo, err := excelize. Abrir arquivo("excel/Plan 61_2022.xlsx")
	if err != nil {
		registro.Fatal(errar)
	}
	c1, erro := arquivo. GetCellValue("Folha1", "A2")
	if err != nil {
		registro.Fatal(errar)
	}
	fmt. Imprimir(c1)
	c2, erro := arquivo. GetCellValue
	*/