package collatzconjecture

import ("errors")

func calculateCollatz (n, counter int) int {
    if n == 1 {
        return counter
    }
    if n % 2 == 0 {
        return calculateCollatz(n/2, counter + 1)
    } else {
        return calculateCollatz(3 * n + 1,counter + 1)
    }
	return counter
}

func CollatzConjecture(n int) (int, error) {
    if n <= 0 {
        return 0, errors.New("Can not calculate the conjecture on numbers less than zero")
    }
	collatz := calculateCollatz(n,0)
	return collatz, nil
}
