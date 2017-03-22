//
//  TableViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/24/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class ClientTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var clients = Client.loadAllClients()
    var contacts = [String: [Client]]()
    var letters: [String] = []
    var animalArray = [Animal]()
    
    var cFirst = ""
    var cLast = ""
    var cEmail = ""
    var cAddress = ""
    var cCellNum = ""

    var filteredClients = [Client]()
    var shouldShowSearchResults = false
    var searchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexClients()
        configureSearchController()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if shouldShowSearchResults {
            return 1
        } else {
            return letters.count
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults {
            return filteredClients.count
        } else {
            return contacts[letters[section]]!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientID", for: indexPath) as! ClientTableViewCell

        if shouldShowSearchResults {
            let f = filteredClients[indexPath.row]
            print(f)
            print(indexPath.row)
            cell.textLabel?.text = f.lName
        } else {
            let c = contacts[letters[indexPath.section]]?[indexPath.row]
            cell.clientName?.text = (c?.lName)! + ", " + (c?.fName)!
            cell.animalNames?.text = c?.cellNum
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if shouldShowSearchResults {
            return ""
        } else {
            return letters[section]
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if shouldShowSearchResults {
            return [""]
        } else {
            return letters
        }
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
        self.tableView.beginUpdates()
        self.isEditing = true
        let newClient = addNewClientData()
        clients.append(newClient)
        let firstLetter = charToString(c: [getFirstLetter(s: newClient.lName)]).capitalized
        if !letters.contains(firstLetter) {
            letters.append(firstLetter)
            contacts[firstLetter] = [Client]()
            letters.sort()
        }
        let clientIndex = contacts[firstLetter]!.count
        let sectionIndex = Int(letters.index(of: firstLetter)!)
        print(letters)
        print(clientIndex)
        print(sectionIndex)
        self.tableView.insertRows(at: [IndexPath(row: clientIndex, section: sectionIndex)], with: .automatic)
        self.tableView.endUpdates()
        self.isEditing = false
    }
    
    @IBAction func cancelNewClient(segue:UIStoryboardSegue) { }

    @IBAction func deleteClient(segue:UIStoryboardSegue) {
        let index: Int = (self.tableView.indexPathForSelectedRow?.row)!
        let section: Int = (self.tableView.indexPathForSelectedRow?.section)!
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [IndexPath(row: index, section: section)], with: .automatic)
        self.tableView.endUpdates()
    }

    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        self.tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }

    func updateSearchResults(for searchController: UISearchController) {
        filteredClients = clients.filter { (client: Client) -> Bool in
            if client.lName.lowercased().contains(searchController.searchBar.text!.lowercased()) {
                return true
            } else {
                return false
            }
        }
        self.tableView.reloadData()
    }

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
            clientCurrentVC.currentClientIndex = index
            clientCurrentVC.currentClientSection = section
        }
    }
}
