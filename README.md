# War-Code

This repository contains code for a public war game implemented in three different languages: Elixir, Haskell, and Rust. The project follows proper software principles and design patterns, such as tail-end recursion and pattern matching, to ensure efficient and maintainable code.

## Files

The repository consists of the following files:

- `War.hs`: Haskell implementation
- `War.ex`: Elixir implementation
- `main.rs`: Rust implementation

## Elixir and Haskell Implementations

In both the Elixir and Haskell implementations, the module "War" is defined. It includes an implementation of the `deal` function, which takes a list of 52 integers representing a shuffled deck of cards. The `deal` function evenly distributes the cards between two players and then recursively calls the `gametime` function to determine the winning player's hand. The winning player's hand is returned as a list of 52 integers.

## Rust Implementation

In the Rust implementation, the `deal` function takes an immutable reference to an array of unsigned 8-bit integers (`u8`). It distributes the cards evenly between two vectors of `u8` and then recursively calls the `gametime` function to play the game. The winning player's hand is converted to a new array of `u8`, and ownership of the new array is returned.

## Usage

To use the code in this repository, follow these steps:

1. Choose the implementation language you prefer (Elixir, Haskell, or Rust).
2. Navigate to the respective file (`War.ex`, `War.hs`, or `main.rs`).
3. Compile or run the file using the appropriate language-specific tools and commands.
4. Write a test-function that provides the necessary input, such as the shuffled deck of cards, as specified in the code.
5. Execute the program and observe the output, which will include the winning player's hand.


## Contact

If you have any questions or inquiries regarding the project, please contact [dylan.ha@torontomu.ca](mailto:dylan.ha@torontomu.ca).

---
