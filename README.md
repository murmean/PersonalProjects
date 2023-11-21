# Zoo Management System

## Overview

The Zoo Management System is a Java-based application that allows users to manage a zoo with different animal enclosures and inhabitants. The system provides functionality for displaying information about cages, animals, and zoo visitors. It also supports sorting and grouping of animals, file-based data storage, and exception handling.

## Classes and Interfaces

### Classes

1. **Cage**
   - Represents an animal enclosure in the zoo.
   - Attributes: `cageNumber`, `resident`, `inhabitants`.
   - Implements `Details` and `Comparable` interfaces.

2. **Animal**
   - Represents an animal in the zoo.
   - Attributes: `name`.
   - Implements `AnimalSounds` and `Comparable` interfaces.

3. **Zoo**
   - Manages a collection of cages.
   - Attributes: `cages`.

4. **InformationBoard**
   - Represents an information board in the zoo.
   - Attributes: `displayText`.
   - Implements the `Details` interface.

### Interfaces

1. **Details**
   - Represents entities that can display details.
   - Defines the `showDetails` method.

2. **AnimalSounds**
   - Represents entities that can make sounds.
   - Defines the `makeSound` method.

## Project Features

1. **Display Cage Information**
   - **Function:** `displayCageInfo`
   - **Usage:** `displayCageInfo <cage_name>`
   - Displays information about a specific cage.

2. **Display All Animals**
   - **Function:** `displayAllAnimals`
   - **Usage:** `displayAllAnimals`
   - Lists all animals in the zoo.

3. **Sort Animals by Vowel Count**
   - **Function:** `sortAnimalsByVowelCount`
   - **Usage:** `sortAnimalsByVowelCount`
   - Sorts animals based on the count of vowels in their names.

### Usage

  - The program accepts command-line arguments for different configurations.

#### Display Cage Information

- **Function:** `displayCageInfo`
- **Usage:** `displayCageInfo <cage_name>`
- Displays information about a specific cage.

#### Display All Animals

- **Function:** `displayAllAnimals`
- **Usage:** `displayAllAnimals`
- Lists all animals in the zoo.

#### Sort Animals by Vowel Count

- **Function:** `sortAnimalsByVowelCount`
- **Usage:** `sortAnimalsByVowelCount`
- Sorts animals based on the count of vowels in their names.

#### Start from Scratch

- **Function:** `startFromScratch`
- **Usage:** `startFromScratch`
- Initializes the zoo from scratch.
