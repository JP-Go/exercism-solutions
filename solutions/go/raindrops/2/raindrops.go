package raindrops

import "fmt"

var divisors = map[int]string {
    3: "Pling",
    5: "Plang",
    7: "Plong",
}

func Convert(number int) string {
	result := ""
    for divisor, sound := range divisors {
        if number % divisor == 0 {
        	result += sound
        }
    }
	if len(result) == 0 {
        return fmt.Sprintf("%v",number)
    }
	return result
}
