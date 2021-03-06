//
// Created by Branden Kaestner on 1/14/17.
// Copyright (c) 2017 BK Development. All rights reserved.
//

import Foundation

struct Animal {
    var name: String
    var type: String
    var sex: String
    var breed: String
    var social: Bool
    var reservation: Reservation?
    var notes: String
    
    
    func getReservation() -> Reservation {
        return self.reservation!
    }
    
    func socialToText() -> String {
        if social {
            return "Yes"
        } else {
            return"No"
        }
    }

    func checkedInToText() -> String {
        if getReservation().checkedIn {
            return "Yes"
        } else {
            return"No"
        }
    }
    
    func getDMY(d:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: d)
    }
    
    func getDMY_time(d:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: d)
    }

    func setTypeSelectorIndex() -> Int {
        if type == "Dog" {
            return 0
        } else {
            return 1
        }
    }

    func setSexSelectorIndex() -> Int {
        if type == "Male" {
            return 0
        } else {
            return 1
        }
    }
}
