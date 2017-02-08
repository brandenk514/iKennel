//
// Created by Branden Kaestner on 1/14/17.
// Copyright (c) 2017 BK Development. All rights reserved.
//

import Foundation

struct Reservation {
    
    let id: Int
    let dateIn: Date
    let dateOut: Date
    let checkedIn: Bool
    
    func getDateIn() -> Date{
        return self.dateIn
    }
    
    func getDateOut() -> Date{
        return self.dateOut
    }
    
    func isCheckedIn() -> Bool {
        return checkedIn
    }
}
