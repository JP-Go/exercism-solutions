package raindrops

import "fmt"

var DIVISORS = []int {
    3,
    5,
    7,
}
var SOUNDS = []string{
    "Pling",
    "Plang",
    "Plong",
}

func Convert(number int) string {
	result := ""
    for i,divisor := range DIVISORS {
        if number % divisor == 0 {
        	result += SOUNDS[i]	
        }
    }
	if len(result) == 0 {
        return fmt.Sprintf("%v",number)
    }
	return result
}
