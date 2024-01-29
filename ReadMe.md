# Pokefly
## Description

PokeDex is an iOS application that allows users to explore information about Pokemons.

The app retrieves data from the [PokeAPI](https://pokeapi.co) and provides a user-friendly interface to browse for Pokemon details.

## Features

- **List View**:
	- Displays a list of Pokemon from the PokeAPI.
	- Each Pokemon entry includes the name, image, and type(s).

- **Detail View**:
	- Tapping on a Pokemon in the list navigates to the detail view.
	- The detail view shows the name, images, type(s), abilities, and moves for the selected Pokemon.

- **Offline Caching**: to be implemented.


## Technical Aspects

- **Development Environment**:
	- Developed using Xcode version 15.1.
- **Frameworks**:
	- Views with `SwiftUI`.
	- Business logic with `Combine`.
- **Architecture**:
	- Implemented using Clean Architecture principles for a modular and maintainable codebase.
- **Data Retrieval**:
	- Used the `PokeAPI` to fetch and display Pokemon data.
- **Code Quality**:
	- Adhered to SOLID principles.
- **Image Loading**:
	- Integrated the `SDWebImage` library via Swift Package Manager for efficient image loading.
- **Unit Testing**:
	- Implemented unit tests for the networking layer.

## Installation

Clone the repository.
Open the project in Xcode.
Build and run the app on your preferred simulator or device.

## Contact

For any inquiries, please contact [Rodrigo Limpias](www.linkedin.com/in/rodrigolimpiascossio).





