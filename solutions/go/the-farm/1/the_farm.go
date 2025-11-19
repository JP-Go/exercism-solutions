package thefarm

import (
	"errors"
	"fmt"
)

type InvalidCowsError struct {
	message string
}

func (ice *InvalidCowsError) Error() string {
	return ice.message
}

// TODO: define the 'DivideFood' function
func DivideFood(calculator FodderCalculator, cows int) (float64, error) {
	amount, err := calculator.FodderAmount(cows)
	if err != nil {
		return 0, err
	}
	factor, err := calculator.FatteningFactor()
	if err != nil {
		return 0, err
	}

	return amount / float64(cows) * factor, nil
}

// TODO: define the 'ValidateInputAndDivideFood' function
func ValidateInputAndDivideFood(calculator FodderCalculator, cows int) (float64, error) {
	if cows <= 0 {
		return 0, errors.New("invalid number of cows")
	}
	return DivideFood(calculator, cows)
}

// TODO: define the 'ValidateNumberOfCows' function
func ValidateNumberOfCows(cows int) error {
	if cows < 0 {
		return &InvalidCowsError{message: fmt.Sprintf("%v cows are invalid: there are no negative cows", cows)}
	} else if cows == 0 {
		return &InvalidCowsError{message: fmt.Sprintf("%v cows are invalid: no cows don't need food", cows)}
	} else {
		return nil
	}
}
