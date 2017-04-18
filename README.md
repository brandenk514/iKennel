# iKennel

An iPhone application to help kennels manage their animals on a day-to-day basis.

iKennel was developed for a UI/UX class a Goucher College and is a study into how to make apps that can be intuitive and easy to use.

## Requirements

Xcode 8.0 or higher and Swift 3.0 or higher

## Installation

Install Xcode and ensure you are using 8.0 and Swift 3.0

## Documentation

Documentation to come

## Github Installation

Install the latest version
```
$ git clone https://github.com/brandenk514/ikennel 
```

## Feedback

Please feel free to give any feedback on this project. If you find any bugs or any enhancements to recommend, please send some of your comments/suggestions to the Github Issues Page.

## Structs

Clients are composed of an array of animal objects. Each animal object is composed some information fields and a Reservation object

### Client
##### Properties:
* id: Int -> for database use
* fName: String -> firstname
* lName: String -> lastname
* address: String
* email: String
* cellNum: String
* animals: Array<Animal> -> An Array of animals owned by the client

### Animal
##### Properties:
* Name: String
* Type: String -> Dog or Cat
* Sex: String ->  Male or Female
* Breed: String
* Social: Bool -> Whether or not the animal is friendly (to other animals)
* Reservation: Reservation -> A Reservation Object
* Notes: String

### Reservation
##### Properties:
* id: Int -> for database use
* Date In: Date
* Date Out: Date
* CheckedIn: Bool -> If animal is present at the kennel


### Disclaimer
I do not take credit for any designs in the app icon. This is a college project and it not intended to be sold in any way
