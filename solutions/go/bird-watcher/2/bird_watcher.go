package birdwatcher

// TotalBirdCount return the total bird count by summing
// the individual day's counts.
func TotalBirdCount(birdsPerDay []int) int {
	total := 0
    for _, i := range birdsPerDay{
        total += i
    } 
	return total
}

// BirdsInWeek returns the total bird count by summing
// only the items belonging to the given week.
func BirdsInWeek(birdsPerDay []int, week int) int { 
    total := 0
    lowerBound := (week - 1) * 7
    for i := lowerBound; i < lowerBound + 7; i++ {
        total = total + birdsPerDay[i]
    }
	return total
}

// FixBirdCountLog returns the bird counts after correcting
// the bird counts for alternate days.
func FixBirdCountLog(birdsPerDay []int) []int {
	for i := 0; i < len(birdsPerDay); i = i + 2 {
        birdsPerDay[i] =  birdsPerDay[i] + 1
    }
	return birdsPerDay
}
