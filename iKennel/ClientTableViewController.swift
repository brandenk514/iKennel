//
//  TableViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/24/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class ClientTableViewController: UITableViewController {

    var clients = Client.loadAllClients()

    var last_names = Array<String>()
    
    var contacts = [Character: [Client]]()
    
    var letters: [Character] = []

override func viewDidLoad() {
    super.viewDidLoad()
    
    letters = clients.map { (name) -> Character in
        return name.lName[name.lName.startIndex]
    }
    
    letters = letters.reduce([], { (list, name) -> [Character] in
        if !list.contains(name) {
            return list + [name]
        }
        return list
    })
    
    
    for c in clients {
        if contacts[c.lName[c.lName.startIndex]] == nil {
            contacts[c.lName[c.lName.startIndex]] = [Client]()
        }
        
        contacts[c.lName[c.lName.startIndex]]!.append(c)
    }
    
    for (letter, list) in contacts {
        contacts[letter] = list.sorted(by: { (client1, client2) -> Bool in
            client1.lName < client2.lName
        })
    }

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

// MARK: - Table view data source

override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return letters.count
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return contacts[letters[section]]!.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath) as! ClientTableViewCell
    
    cell.clientName?.text = clients[indexPath.row].lName //contacts[letters[indexPath.row]].lName as? String
    cell.animalNames?.text = clients[indexPath.row].cellNum
    
    return cell
}

override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return String(Array(letters)[section])
}

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
