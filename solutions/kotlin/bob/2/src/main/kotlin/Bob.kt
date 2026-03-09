object Bob {
    fun hey(input: String) = when {
        input.isSilence() -> "Fine. Be that way!"
        input.isQuestion() && input.isShouting() -> "Calm down, I know what I'm doing!"
        input.isShouting() -> "Whoa, chill out!"
        input.isQuestion() -> "Sure."
        else -> "Whatever."
	}

    private fun String.isSilence() = this.isBlank()
    private fun String.isQuestion() = this.trim().endsWith("?")
    private fun String.isShouting() =  uppercase() == this && any(Char::isLetter)
}