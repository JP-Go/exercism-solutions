package chessboard
import "fmt"
// Declare a type named File which stores if a square is occupied by a piece - this will be a slice of bools
type File = []bool

// Declare a type named Chessboard which contains a map of eight Files, accessed with keys from "A" to "H"
type Chessboard map[string]File
// CountInFile returns how many squares are occupied in the chessboard,
// within the given file.
func CountInFile(cb Chessboard, file string) int {
	f,ok := cb[file]
    if !ok {
        return 0
    }
	count := 0
    for _,x := range f {
        if(x){ 
            count += 1
        }
    } 
	return count
}

// CountInRank returns how many squares are occupied in the chessboard,
// within the given rank.
func CountInRank(cb Chessboard, rank int) int {
	count := 0
    if (rank < 1 || rank >8 ){
        return count 
    } 
    for _,file := range cb {
        if(file[rank - 1]){
			count += 1
        }
    	fmt.Println(file, count)
    }
	return count
}

// CountAll should count how many squares are present in the chessboard.
func CountAll(cb Chessboard) int {
	count := 0
    for _,file := range cb {
        count += len(file)
    }
	return count
}

// CountOccupied returns how many squares are occupied in the chessboard.
func CountOccupied(cb Chessboard) int {
	count := 0
    for _,file := range cb {
        for _, item := range file {
            if (item){
                count += 1
            }
        } 
    }
	return count
}
