// Package weather provides utilities to get information about the weather.
package weather

// CurrentCondition is the current weaather condition.
var CurrentCondition string

// CurrentLocation is the current location where the weather condition is verified at.
var CurrentLocation string

// Forecast: Returns the current forecast if given a city and a condition.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
