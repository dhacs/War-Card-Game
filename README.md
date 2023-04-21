# War-Code
Code for the public war game repository.

Contains 3 Files:

War.hs - **haskell** implementation

War.ex - **elixir** implementation 

main.rs - **rust** implementation


This project was programmed in three diferent languages: Elixir, Haskell, and Rust. It follows proper software principles and design patterns such as tail-end recursion and pattern matching.

In both Elixir and Haskell, the module "War" is defined and the 'deal' function is implemented, which takes a list of 52 integers representing a shuffled deck of cards, distributes the cards evenly between two players, and then calls the 'gametime' function recursively to determine and return the winning player's hand as a list of 52 integers.

In Rust, the 'deal' function takes an immutable reference to an array of unsigned 8-bit integers (u8), distributes the cards evenly to two vectors of u8, and calls the gametime function recursively to play the game. It converts the winning player's hand to a new array of u8 and returns it's ownership.
