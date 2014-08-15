package main

import (
	"flag"
	"github.com/astaxie/beego"
)

func init() {
	const (
		defaultPort = 8080
		usage       = "set port"
	)
	flag.IntVar(&beego.HttpPort, "port", defaultPort, usage)
}

func main() {
    flag.Parse()
    beego.Run()
}
