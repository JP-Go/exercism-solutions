object Bob {
    fun hey(input: String) = when {
        !input.isNotBlank() -> "Fine. Be that way!"
        input.uppercase() == input && input.trim().endsWith("?") && input.any(Char::isLetter)-> "Calm down, I know what I'm doing!"
        input.uppercase() == input && input.any(Char::isLetter)-> "Whoa, chill out!"
        input.trim().endsWith("?") -> "Sure."
        else -> "Whatever."
	}
}