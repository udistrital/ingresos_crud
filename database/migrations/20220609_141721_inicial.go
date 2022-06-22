package main

import (
	"fmt"
	"io/ioutil"
	"strings"

	"github.com/astaxie/beego/migration"
)

// DO NOT MODIFY
type Inicial_20220609_141721 struct {
	migration.Migration
}

// DO NOT MODIFY
func init() {
	m := &Inicial_20220609_141721{}
	m.Created = "20220609_141721"

	migration.Register("Inicial_20220609_141721", m)
}

// Run the migrations
func (m *Inicial_20220609_141721) Up() {
	file, err := ioutil.ReadFile("../scripts/20220609_141721_inicial_up.sql")

	if err != nil {
		// handle error
		fmt.Println(err)
	}

	requests := strings.Split(string(file), ";\n")

	for _, request := range requests {
		fmt.Println(request)
		m.SQL(request)
		// do whatever you need with result and error
	}
}

// Reverse the migrations
func (m *Inicial_20220609_141721) Down() {
	file, err := ioutil.ReadFile("../scripts/20220609_141721_inicial_down.sql")

	if err != nil {
		// handle error
		fmt.Println(err)
	}

	requests := strings.Split(string(file), ";\n")

	for _, request := range requests {
		fmt.Println(request)
		m.SQL(request)
		// do whatever you need with result and error
	}

}
