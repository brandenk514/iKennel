//
// Created by Branden Kaestner on 1/14/17.
// Copyright (c) 2017 BK Development. All rights reserved.
//

import Foundation

struct Animal {
    let name: String
    let type: String
    let sex: String
    let breed: String
    let social: Bool
    let reservation: Reservation?
    let notes: String
    
    
    func getReservation() -> Reservation {
        return self.reservation!
    }
    
    func convertBoolToText() -> String {
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
