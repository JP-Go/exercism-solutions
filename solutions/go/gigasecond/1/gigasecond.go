
package gigasecond

// import path for the time package from the standard library
import (
    "time"
    "fmt"
)

const gigasecond = int(1e9)


// AddGigasecond should have a comment documenting it.
func AddGigasecond(t time.Time) time.Time {
    duration, _ := time.ParseDuration(fmt.Sprintf("%vs",gigasecond))
    return t.Add(duration)
}
