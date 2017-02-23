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
    
    var contacts = [Character: [Client]]()
    
    var letters: [Character] = []
    
    var cFirst = ""
    var cLast = ""
    var cEmail = ""
    var cAddress = ""
    var cCellNum = ""
    
    var animalName = ""
    var aType = ""
    var aBreed = ""
    var aSex = ""
    var aSocial = true
    var aNotes = ""
    
    var resDateIn = Date()
    var resDateOut = Date()
    var checkedIn = false
    
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
        return charToString(c: letters)
    }
    
    func indexClients() {
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
        
        letters.sort()
        
        for (letter, list) in contacts {
            contacts[letter] = list.sorted(by: { (client1, client2) -> Bool in
                client1.lName < client2.lName
            })
        }
    }
    
    func charToString(c:[Character]) -> [String] {
        var s = [String]()
        for i in c {
            s.append(String(i))
        }
        return s
    }
    
    func addNewClientData() -> Client
    {
        var aArray = [Animal]()
        let r = Reservation(dateIn: resDateIn, dateOut: resDateOut, checkedIn: checkedIn)
        let a0 = Animal(name: animalName, type: aType, sex: aSex, breed: aBreed, social: aSocial, reservation: r, notes: aNotes)
        aArray.append(a0)
        let c = Client(fName: cFirst, lName: cLast, address: cAddress, email: cEmail, cellNum: cCellNum, animals: aArray)
        print(c)
        return c
    }
    
    @IBAction func addNewClient(segue:UIStoryboardSegue) {
        clients.append(addNewClientData())
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: contacts.count - 1, section: contacts.count)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    @IBAction func editCurrentClient(segue:UIStoryboardSegue) { }
    
    @IBAction func cancelNewClient(segue:UIStoryboardSegue) { }
    
    @IBAction func cancelCurrentClient(segue:UIStoryboardSegue) { }
    
    
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
