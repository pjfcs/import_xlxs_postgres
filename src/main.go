package main

import (
    "fmt"

    "github.com/xuri/excelize/v2"
)

/*
//
// criar arquivo excel de teste
//
func main() {
    f := excelize.NewFile()
	xlsx := "excel/teste.xlsx"
    index := f.NewSheet("Sheet2")
    f.SetCellValue("Sheet2", "A2", "Hello world.")
    f.SetCellValue("Sheet1", "B2", 100)
    f.SetActiveSheet(index)
    if err := f.SaveAs(xlsx); err != nil {
        fmt.Println(err)
    }
}
*/

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