//
//  TableViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/24/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class ClientTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var contacts = Client.loadAllClients()
    var letters = [String]()
    var filteredClients = [Client]()

    var animalArray = [Animal]()
    
    var cFirst = ""
    var cLast = ""
    var cEmail = ""
    var cAddress = ""
    var cCellNum = ""
    
    var deleteIndex = 0
    var deleteSection = 0

    var shouldShowSearchResults = false
    var searchController : UISearchController!
    
    var editIndex = 0
    var editSection = 0
    
    var editedClient = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexClients()
        configureSearchController()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(editedClient)
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
            return contacts[section].clients.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientID", for: indexPath) as! ClientTableViewCell
        if shouldShowSearchResults {
            let c = filteredClients[indexPath.row]
            cell.clientName?.text = (c.lName) + ", " + (c.fName)
            cell.animalNames?.text = c.cellNum
        } else {
            let c = contacts[indexPath.section].clients[indexPath.row]
            cell.clientName?.text = (c.lName) + ", " + (c.fName)
            cell.animalNames?.text = c.cellNum
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
        letters = {
            return contacts.map{ $0.letter }
        }()
        letters.sort()
        contacts = contacts.sorted { (c1 , c2) -> Bool in
            c1.letter < c2.letter
        }
    }
    
    func addNewClientData() -> Client
    {
        return Client(fName: cFirst, lName: cLast, address: cAddress, email: cEmail, cellNum: cCellNum, animals: animalArray)
    }
    
    @IBAction func addNewClient(segue:UIStoryboardSegue) {
        let newClient = addNewClientData()
        let firstLetter = newClient.getFirstLetter(s: cLast).capitalized
        for contact in contacts {
            if firstLetter == contact.letter {
                contact.add(client: newClient)
            } else {
                let tempContact = Contact(letter: firstLetter, clients: [newClient])
                contacts.append(tempContact)
                break
            }
        }
        indexClients()
        self.tableView.reloadData()
    }
    
    @IBAction func cancelNewClient(segue:UIStoryboardSegue) { }

    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        self.definesPresentationContext = true
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
        filteredClients.removeAll()
        for contact in contacts {
            let filteredContent = contact.clients.filter {$0.lName.range(of: searchController.searchBar.text!, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }
            if !filteredContent.isEmpty {
                filteredClients = filteredContent
            }
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            contacts[indexPath.section].clients.remove(at: indexPath.row)
            if contacts[indexPath.section].clients.count == 0 {
                contacts.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .fade)
                indexClients()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view
        if segue.identifier == "currentClient" {
            let index: Int = (self.tableView.indexPathForSelectedRow?.row)!
            let section: Int = (self.tableView.indexPathForSelectedRow?.section)!
            let clientCurrentVC = segue.destination as! CurrentClientViewController
            if shouldShowSearchResults {
                clientCurrentVC.cur_client = filteredClients[index]
            } else {
                clientCurrentVC.cur_client = contacts[section].clients[index]
                clientCurrentVC.currentClientIndex = editIndex
                clientCurrentVC.currentClientSection = editSection
            }
        }
    }
}
