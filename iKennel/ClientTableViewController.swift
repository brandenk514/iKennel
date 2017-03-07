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
    
    var contacts = [String: [Client]]()
    
    var letters: [String] = []
    
    var cFirst = ""
    var cLast = ""
    var cEmail = ""
    var cAddress = ""
    var cCellNum = ""

    var animalArray = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexClients()
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
        let c = contacts[letters[indexPath.section]]?[indexPath.row]
        cell.clientName?.text = (c?.lName)! + ", " + (c?.fName)!
        cell.animalNames?.text = c?.cellNum
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(Array(letters)[section])
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letters
    }
    
    func indexClients() {
        for c in clients {
            let key = "\(c.lName[c.lName.startIndex])".uppercased()

            if var letterValues = contacts[key] {
                letterValues.append(c)
                contacts[key] = letterValues
            } else {
                contacts[key] = [c]
            }
        }
        letters = [String](contacts.keys)
        letters.sort()
    }

    func charToString(c:[Character]) -> String {
        var s = [String]()
        for i in c {
            s.append(String(i))
        }
        return s[0]
    }

    func getFirstLetter(s:String) -> Character {
        return s.characters[s.startIndex]
    }
    
    func addNewClientData() -> Client
    {
        return Client(fName: cFirst, lName: cLast, address: cAddress, email: cEmail, cellNum: cCellNum, animals: animalArray)
    }
    
    @IBAction func addNewClient(segue:UIStoryboardSegue) {
        let newClient = addNewClientData()
        clients.append(newClient)
        print(newClient)

        /*let firstLetter = charToString(c: [getFirstLetter(s: newClient.lName)]).capitalized

        if !letters.contains(firstLetter) {
            letters.append(firstLetter)
            contacts[firstLetter] = [Client]()
        }
        contacts[firstLetter]!.append(newClient)

        let sectionIndex = Int(letters.index(of: firstLetter)!)

        let clientIndex = contacts[firstLetter]!.count

        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: clientIndex, section: sectionIndex)], with: .automatic)
        self.tableView.endUpdates()*/
    }
    
    @IBAction func cancelNewClient(segue:UIStoryboardSegue) { }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "currentClient" {
            let index: Int = (self.tableView.indexPathForSelectedRow?.row)!
            let section: Int = (self.tableView.indexPathForSelectedRow?.section)!
            let clientCurrentVC = segue.destination as! CurrentClientViewController
            clientCurrentVC.cur_client = (contacts[letters[section]]?[index])!
        }
    }
}
