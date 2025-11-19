package purchase

const resellPctOlderThan10Years  = 0.5
const resellPctOlderThan3Years   = 0.7
const resellPctYoungerThan3Years = 0.8

// NeedsLicense determines whether a license is needed to drive a type of vehicle. Only "car" and "truck" require a license.
func NeedsLicense(kind string) bool {
	return kind == "car" || kind == "truck"
}

// ChooseVehicle recommends a vehicle for selection. It always recommends the vehicle that comes first in lexicographical order.
func ChooseVehicle(option1, option2 string) string {
	if shouldChooseOption1 := option1 < option2; shouldChooseOption1 == true {
        return option1 + " is clearly the better choice."
    }
	return option2 + " is clearly the better choice."
}

// CalculateResellPrice calculates how much a vehicle can resell for at a certain age.
func CalculateResellPrice(originalPrice, age float64) float64 {
	if age >= 10 {
        return float64(originalPrice) * resellPctOlderThan10Years
    }else if (age > 3){
    	return float64(originalPrice) * resellPctOlderThan3Years
    }else{
		return float64(originalPrice) * resellPctYoungerThan3Years
    }

}
