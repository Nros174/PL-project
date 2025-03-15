package main

import (
    "fmt"
)

func main() {
    var fahrenheit, celsius float64
    fmt.Print("enter degree in fahrenheit: ")
    fmt.Scanf("%f", &fahrenheit)
    celsius = (5.0 / 9.0) * (fahrenheit - 32)
    fmt.Printf("%.2f fahrenheit = %.2f celsius\n", fahrenheit, celsius)
}
