package elon

import "fmt"

// The Drive function cycles the car by one drive cycle. It decrements the battery its batteryDrain 
// and increments the distance by its speed
func (c *Car) Drive() {
    if (c.battery - c.batteryDrain < 0){
        return 
    }
    c.battery -= c.batteryDrain
    c.distance += c.speed
}

// The DisplayDistance function returns a string presentation of the distance driven by the car
func (c *Car) DisplayDistance() string {
    return fmt.Sprintf("Driven %v meters",c.distance)
}

// The DisplayBattery function returns a string presentation of the distance driven by the car
func (c *Car) DisplayBattery() string {
    return fmt.Sprintf("Battery at %v%%",c.battery)
}
// The CanFinish function receives the track's length and returns a boolean indicating if, in its present state, the car can drive all the track's distance 
func (c *Car) CanFinish(trackDistance int) bool {
    cyclesNeeded := float64(trackDistance) / float64(c.speed)
    batteryNeeded := cyclesNeeded * float64(c.batteryDrain)
    return float64(c.battery) >= batteryNeeded  
    
}
