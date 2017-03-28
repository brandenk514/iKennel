//
//  ReservationContact.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/28/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import Foundation

struct ReservationContact {
    let letter : String
    var animals : [Animal]
    
    init (letter: String, animals: [Animal] = [Animal]()) {
        self.letter = letter
        self.animals = animals
    }
    
    mutating func add(animal: Animal) {
        animals.append(animal)
    }
}
