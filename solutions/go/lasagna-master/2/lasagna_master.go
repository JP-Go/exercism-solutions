package lasagna

const (
    defaultAvgTimePerLayer       = 2
    gramsOfNoodlesPerNoodleLayer = 50
    litersOfSaucePerSauceLayer   = 0.2
    defaultServingOfIngredients  = 2
)

// The PreparationTime function takes a slice of layers and the average
// preparation time of each layer and returns an estimate of the 
// preparation time for making a lasagna
func PreparationTime(layers []string, avgTimePerLayer int) int {
    if (avgTimePerLayer <= 0){
        avgTimePerLayer = defaultAvgTimePerLayer
    }
	return avgTimePerLayer * len(layers)
}
// TODO: define the 'Quantities()' function
func Quantities(layers []string) (int,float64) {
    weightInNoodles := 0
    litersOfSauce := float64(0)
    for _,ingredient := range layers {
        if (ingredient == "noodles"){
            weightInNoodles += gramsOfNoodlesPerNoodleLayer
        }
    	if (ingredient == "sauce"){
            litersOfSauce += litersOfSaucePerSauceLayer
        }
    }
	return weightInNoodles,litersOfSauce
}

// TODO: define the 'AddSecretIngredient()' function
func AddSecretIngredient(friendsIngredients, myIngredients []string) {
    myIngredients[len(myIngredients) - 1] = friendsIngredients[len(friendsIngredients) -1] 
}

// TODO: define the 'ScaleRecipe()' function
func ScaleRecipe(quantities []float64, amountOfPortions int)[]float64{
    amountToScale := float64(amountOfPortions) / defaultServingOfIngredients
    var newQuantities []float64
    for _,quantity := range quantities {
        newQuantities = append(newQuantities, quantity * amountToScale)
    } 
    return newQuantities
}

