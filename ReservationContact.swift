//
//  ReservationContact.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/28/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import Foundation

struct ReservationContact {
    let date : String
    var animals : [Animal]
    
    init (date: String, animals: [Animal] = [Animal]()) {
        self.date = date
        self.animals = animals
    }
    
    mutating func add(animal: Animal) {
        animals.append(animal)
    }
}
