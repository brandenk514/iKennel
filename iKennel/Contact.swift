//
//  File.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/27/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import Foundation

class Contact {
    let letter : String
    var clients : [Client]
    
    init (letter: String, clients: [Client] = [Client]()) {
        self.letter = letter
        self.clients = clients
    }
    
    func add(client: Client) {
        clients.append(client)
    }
}



