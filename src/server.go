package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var pingCounter = prometheus.NewCounter(
	prometheus.CounterOpts{
		Name: "ping_request_count",
		Help: "No of request handled by Ping handler",
	},
)

func ping(w http.ResponseWriter, req *http.Request) {
	pingCounter.Inc()
	fmt.Fprintf(w, "pong")
}

func main() {
	prometheus.MustRegister(pingCounter)

	http.HandleFunc("/ping", ping)
	fmt.Println("Running")
	http.Handle("/metrics", promhttp.Handler())

	httpPort := os.Getenv("PORT")
	if httpPort == "" {
		httpPort = "80"
	}

	http.ListenAndServe(":"+httpPort, nil)
}
