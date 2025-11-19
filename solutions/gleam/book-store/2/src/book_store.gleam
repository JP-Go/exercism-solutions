import gleam/list
import gleam/dict
import gleam/int
import gleam/float
import gleam/order

const book_base_price = 800.0

fn naive_grouping(books: List(Int)) -> List(Int) {
    case list.length(books) {
        0 -> []
        _ ->  {
            let frequency = list.group(books, fn (n) { n }) 
                |> dict.map_values(fn (_,val){ list.length(val) })
            let grouping_size = frequency |> dict.keys |> list.length
            let updated_frequency = dict.map_values(frequency, fn (_,val) { val - 1 }) 
                |> dict.filter(fn(_,val){ val > 0 })
            let updated_list_of_books = dict.to_list(updated_frequency)
                |> list.flat_map(fn(entry) { list.repeat(entry.0, entry.1) })
            [grouping_size,..naive_grouping(updated_list_of_books)]
        }
    }
}

fn book_set_price(book_quantity: Int, unique_books_count: Int) -> Float {
    case unique_books_count {
        1 -> 1.0
        2 -> 0.95
        3 -> 0.90
        4 -> 0.80
        5 -> 0.75
        _ -> 1.0
    } *. int.to_float(book_quantity) *. book_base_price
}

fn sort_groupings_larger_to_smaller(groupings: List(Int)) -> List(Int){
    list.sort(groupings, order.reverse(int.compare))
}

fn optimize_trees_and_fives(groupings: List(Int)) -> List(Int){
    case list.count(groupings, fn(x){ x == 3 }), list.count(groupings, fn(x){ x == 5 }) {
        0, 0 -> groupings
        i, j if i > 0 && j > 0 -> {
            let no_trees_and_fives = list.filter(groupings, fn(x) { x != 3 && x != 5})
            no_trees_and_fives |> list.append(list.repeat(4,int.min(i,j) * 2))
            |> list.append(list.repeat(3, int.max(0,i - j))) 
            |> list.append(list.repeat(5, int.max(0,j - i)))

        }
        _, _ -> groupings

    }
}


fn reorder_groupings(groupings:List(Int)) -> List(Int) {
    case groupings {
        [] | [_] -> groupings
        _ -> list.chunk(groupings, by: fn(x) { x }) 
                |> list.interleave 
                |> list.sized_chunk(2) 
                |> list.flat_map(minimize_pair)
                |> optimize_trees_and_fives
    }
}

fn minimize_pair(pair: List(Int)) {
    case pair {
        [] | [_] -> pair
        _ -> {
            let assert [a,b] = pair
            let pairings = list.range(a,b) 
            |> list.zip(list.reverse(list.range(a,b))) 
            |> list.map(fn (p) { #(p,total_group([p.0,p.1])) } )
            let assert [first_pair,.._rest] = pairings
            let min_pair_with_price = pairings |> list.fold(first_pair,fn (acc, cur) {
                case float.compare(cur.1,acc.1) {
                    order.Lt | order.Eq -> cur
                    _ -> acc
                }
            })
            let #(min_pair,_) = min_pair_with_price
            [min_pair.0, min_pair.1]
        }
    }
    
}

fn total_group(groups: List(Int)){
    groups |> list.map(fn(book_count) {book_set_price(book_count, book_count)}) |> float.sum
}

pub fn lowest_price(books: List(Int)) -> Float {
    let naive_groups = naive_grouping(books) |> sort_groupings_larger_to_smaller
    let groups = reorder_groupings(naive_groups) 
    total_group(groups)
}
