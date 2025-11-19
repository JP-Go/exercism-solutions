package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch card {
        case "ace": return 11
    	case "two": return 2
        case "three": return 3
        case "four": return 4
        case "five": return 5
    	case "six": return 6
    	case "seven": return 7
    	case "eight": return 8
    	case "nine": return 9
    	case "ten","jack","king","queen": return 10
    	default: return 0
    }
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	value1 := ParseCard(card1)
    value2 := ParseCard(card2) 
    handValue := value1 + value2
    dealerHandValue := ParseCard(dealerCard)
    switch {
        // Split if two aces
        case card1 == "ace" && card2 == "ace":
    		return "P"
        case handValue == 21:
    		// Win if dealer has no card with value at least 10
    		if dealerHandValue < 10 {
                return "W"
            }else{
            	return "S" 
            }
    	case handValue <= 11:
    		return "H"
		case handValue >= 17 && handValue <= 20:
    		return "S"
        case handValue >= 12 && handValue <= 16:
    		if dealerHandValue < 7{
                return "S"
            }else{
            	return "H"
            }     
    	default:
    		panic("Invalid game state")
    }
}
