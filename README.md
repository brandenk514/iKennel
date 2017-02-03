# iKennel

An iPhone application to help kennels manage their animals on a day-to-dy basis.

iKennel was developed for a UI/UX class a Goucher College and is a study into how to make apps that can be intuitive and easy to use.

Clients are composed of an array of animal objects. Each animal is composed of a Reservation object and an array of Vaccine objects

## Structs

### Client
##### Properties:
* id: Int -> for database use
* fName: String -> firstname
* flName: String -> lastname
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

### Vaccine
##### Properties:
* Name: String
* dateTaken: Date
* dateToUpdate: Date
