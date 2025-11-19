package twofer

// function ShareWith accepts a name,a string representing the name of a friend, and 
// returs a string in the following template: 'One for <name>, one for me.'. If name is a empty string, then the function substitutes <name> for the word 'you'. 
func ShareWith(name string) string {
	if (name == ""){
        return "One for you, one for me."
    }
	return "One for " + name + ", one for me."
}
