//
//  Client.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/14/17.
//  Copyright (c) 2017 BK Development. All rights reserved.
//

import Foundation

struct Client {

    var fName: String
    var lName: String
    var address: String
    var email: String
    var cellNum: String
    var animals: Array<Animal>?
    
    func getAnimals() -> [Animal] {
        return self.animals!
    }
    
    func getAnimalNames() -> String {
        var aNames = [String]()
        for a in self.animals! {
            aNames.append(a.name)
        }
        return aNames.joined(separator: ", ")
    }
}

extension Client {
    static func loadAllClients() -> [Client] {
        return loadAllClientsForTest()
    }

    static func loadAllClientsForTest() -> [Client] {
        var clients = [Client]()
        var mAnimals = [Animal]()
        var sAnimals = [Animal]()
        var m2animals = [Animal]()
        
        let tempCal = Calendar.current
        
        let ny = TimeZone(identifier: "America/New York")
        
        let date1 = DateComponents(calendar: nil, timeZone: ny, era: nil, year: 2017, month: 01, day: 15, hour: 13, minute: 12, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        
        let date2 = DateComponents(calendar: nil, timeZone: ny, era: nil, year: 2017, month: 01, day: 19, hour: 14, minute: 12, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let date3 = DateComponents(calendar: nil, timeZone: ny, era: nil, year: 2017, month: 01, day: 25, hour: 15, minute: 12, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let date4 = DateComponents(calendar: nil, timeZone: ny, era: nil, year: 2017, month: 02, day: 15, hour: 16, minute: 12, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)

        let reserve0 = Reservation(dateIn: tempCal.date(from: date1)!, dateOut: tempCal.date(from: date2)!, checkedIn: false)
        let animal0 = Animal(name: "Meeko", type: "Dog", sex: "male", breed: "German Shepard", social: true, reservation: reserve0, notes: "")
        mAnimals.append(animal0)

        let reserve1 = Reservation(dateIn: tempCal.date(from: date2)!, dateOut: tempCal.date(from: date3)!, checkedIn: true)
        let reserve2 = Reservation(dateIn: tempCal.date(from: date3)!, dateOut: tempCal.date(from: date4)!, checkedIn: false)
        let animal1 = Animal(name: "Prince", type: "Dog", sex: "male", breed: "husky", social: false, reservation: reserve1, notes: "")
        let animal2 = Animal(name: "Lady", type: "Dog", sex: "female", breed: "pug", social: true, reservation: reserve2, notes: "")
        sAnimals.append(animal1)
        sAnimals.append(animal2)
        
        let reserve3 = Reservation(dateIn: tempCal.date(from: date2)!, dateOut: tempCal.date(from: date4)!, checkedIn: true)
        let animal3 = Animal(name: "Sol", type: "Cat", sex: "female", breed: "German Shepard", social: true, reservation: reserve3, notes: "")
        m2animals.append(animal3)

        let client0 = Client(fName: "Mark", lName: "Sanchez", address: "123 Wall Street", email: "ms@gmail.com", cellNum: "201-233-1222", animals: mAnimals)
        let client1 = Client(fName: "Samantha", lName: "Smith", address: "234 Wall Street", email: "ss@gmail.com", cellNum: "210-453-2211", animals: sAnimals)
        let client2 = Client(fName: "Mary", lName: "Doe", address: "775 Saint Lane", email: "md@gmail.com", cellNum: "122-345-6677", animals: m2animals)
        clients.append(client0)
        clients.append(client1)
        clients.append(client2)

        return clients
    }
}

