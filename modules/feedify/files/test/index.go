package main

import (
	"flag"
	"github.com/astaxie/beego"
)

var configPath string

func init() {
	const (
		defaultPort       = 8080
		defaultConfigPath = "app.conf"
	)
	flag.IntVar(&beego.HttpPort, "port", defaultPort, "set port")
	flag.StringVar(&configPath, "config", defaultConfigPath, "set config file path")
}

func main() {
    flag.Parse()
    beego.Run()
}
