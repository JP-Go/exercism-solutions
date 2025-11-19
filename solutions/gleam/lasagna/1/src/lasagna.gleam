/// Total time in the oven in minutes for preparing a lasagna 
const total_oven_time_in_min: Int = 40
/// Time preparing each layer of a lasagna in minutes 
const preparation_time_for_layer_in_min: Int = 2

/// returns the expected time in minutes that a lasagna should be in the oven
pub fn expected_minutes_in_oven() -> Int{
  total_oven_time_in_min
}
/// Computes the remaining time in minutes in the oven given the time in minutes 
/// that the lasagna was already in the oven 
pub fn remaining_minutes_in_oven(minutes_in_oven: Int) -> Int{
  total_oven_time_in_min - minutes_in_oven
}
/// Computes the time in minutes for preparing a lasagna given the number of layers
pub fn preparation_time_in_minutes(number_of_layers for_layers: Int) -> Int{
  preparation_time_for_layer_in_min * for_layers
}
/// Gives the total time in minutes passed making the lasagna given
/// the number of layers and the time passed in the oven
pub fn total_time_in_minutes(layers: Int, time_in_oven: Int) -> Int{
  preparation_time_in_minutes(layers) + time_in_oven
}
/// Dings when the lasagna is ready
pub fn alarm(){
  "Ding!"
}