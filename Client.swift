//
//  Client.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/14/17.
//  Copyright (c) 2017 BK Development. All rights reserved.
//

import Foundation

struct Client {

    let id: Int
    let fName: String
    let lName: String
    let address: String
    let email: String
    let cellNum: String
    let animals: Array<Animal>
}

extension Client {
    static func loadAllClients() -> [Client] {
        return loadAllClientsForTest()
    }

    static func loadAllClientsForTest() -> [Client] {
        var clients = [Client]()
        var mAnimals = [Animal]()
        var sAnimals = [Animal]()

        let reserve0 = Reservation(id: 0, dateIn: Date(), dateOut: Date(), checkedIn: false)
        let animal0 = Animal(name: "Meeko", sex: "male", breed: "German Shepard", social: true, reservation: reserve0)
        mAnimals.append(animal0)

        let reserve1 = Reservation(id: 1, dateIn: Date(), dateOut: Date(), checkedIn: true)
        let reserve2 = Reservation(id: 2, dateIn: Date(), dateOut: Date(), checkedIn: false)
        let animal1 = Animal(name: "Prince", sex: "male", breed: "husky", social: false, reservation: reserve1)
        let animal2 = Animal(name: "lady", sex: "female", breed: "pug", social: true, reservation: reserve2)
        sAnimals.append(animal1)
        sAnimals.append(animal2)

        let client0 = Client(id: 0, fName: "Mark", lName: "S.", address: "123 Wall Street", email: "ms@gmail.com", cellNum: "201-233-1222", animals: mAnimals)
        let client1 = Client(id: 1, fName: "Samantha", lName: "Smith", address: "234 Wall Street", email: "ss@gmail.com", cellNum: "210-453-2211", animals: sAnimals)
        clients.append(client0)
        clients.append(client1)

        return clients
    }
}

