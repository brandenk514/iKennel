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
    let cellNum: Int
    let animals: Array<Animal>
}

extension Client {
    static func loadAllClients() -> [Client] {
        return loadAllClientsFromPlist("clientList")
    }

    fileprivate static func loadAllClientsFromPlist(_ plistName: String) -> [Client] {
        let path = Bundle.main.path(forResource: plistName, ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)

        let dictArray = plist as! [[String: String]]

        print(dictArray[0]["id"])

        var clients = [Client]()

        return clients
    }
}

