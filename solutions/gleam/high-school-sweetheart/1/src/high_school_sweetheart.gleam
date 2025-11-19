import gleam/string
import gleam/list

pub fn first_letter(name: String) -> String {
  let assert Ok(fl) = name |> string.trim  |> string.first
  fl
}

pub fn initial(name: String) -> String{
  name |> first_letter |> string.capitalise <> "."
}

pub fn initials(full_name: String) -> String {
  full_name |> string.split(on: " ") |> list.map(initial) |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) {
  let ini1 = full_name1 |> initials
  let ini2 = full_name2 |> initials
  "\n     ******       ******" <> "\n" <>
  "   **      **   **      **" <> "\n" <>
  " **         ** **         **" <> "\n" <>
  "**            *            **" <> "\n" <>
  "**                         **" <> "\n" <>
  "**     "<>ini1<>"  +  "<>ini2<>"     **" <> "\n" <>
  " **                       **" <> "\n" <>
  "   **                   **" <> "\n" <>
  "     **               **" <> "\n" <>
  "       **           **" <> "\n" <>
  "         **       **" <> "\n" <>
  "           **   **" <> "\n" <>
  "             ***" <> "\n" <>
  "              *"<> "\n"
}
