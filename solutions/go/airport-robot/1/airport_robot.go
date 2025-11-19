package airportrobot

import "fmt"

type Greeter interface  {
    LanguageName() string
    Greet (s string) string
}

type Italian struct {}

type Portuguese struct {}

func (g Italian) LanguageName() string {
    return "Italian"
}

func (g Italian) Greet(visitor string) string {
	return fmt.Sprintf("%s %s!","Ciao", visitor)
}

func (g Portuguese) LanguageName() string{
    return "Portuguese"    
}

func (g Portuguese) Greet(visitor string) string{
    return fmt.Sprintf("%s %s!","Olá", visitor)    
}

func SayHello(visitor string, greeter Greeter) string{
    return fmt.Sprintf("I can speak %s: %s",greeter.LanguageName(), greeter.Greet(visitor))
}