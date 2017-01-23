//
//  SecondViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 12/29/16.
//  Copyright © 2016 BK Development. All rights reserved.
//

import UIKit


class ClientsViewController: UITableViewController {

    var clients = [Client]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clients = Client.loadAllClients()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientCell", for: indexPath) as! ClientTableViewCell
        let client = clients[indexPath.row]
        cell.nameLabel.text = client.fName + " " + client.lName
        return cell
    }
}

