//
//  TableViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/24/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class ReservationTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var clients = [Contact]()
    var clientAnimals = [ReservationContact]()
    var animals = [Animal]()
    var dates: [String] = []
    var newReservationEntry = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    var editReservation = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var filteredAnimals = [Animal]()
    var shouldShowSearchResults = false
    var searchController : UISearchController!
    
    var tabBarcontroller = iKennelTabBarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clients = tabBarcontroller.clients
        indexReservations()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarcontroller.clients = clients
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
            return dates.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults {
            return filteredAnimals.count
        } else {
            return clientAnimals[section].animals.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservation", for: indexPath) as! ReservationTableViewCell
        if shouldShowSearchResults {
            let selected = filteredAnimals[indexPath.row]
            cell.clientName.text = selected.name
            cell.animalNames.text = selected.checkedInToText()
        } else {
            let selected = clientAnimals[indexPath.section].animals[indexPath.row]
            cell.clientName.text = selected.name
            cell.animalNames.text = "Checked In: " + selected.checkedInToText()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if shouldShowSearchResults {
            return ""
        } else {
            return dates[section]
        }
    }
    
    @IBAction func addNewReservation(segue:UIStoryboardSegue) {
        let reservDateIn = newReservationEntry.getDMY(d: (newReservationEntry.reservation?.dateIn)!)
        for c in clientAnimals {
            if reservDateIn == c.date {
                //c.add(animal: newReservationEntry)
            } else {
                clientAnimals.append(ReservationContact(date: reservDateIn, animals: [newReservationEntry]))
                break
            }
        }
        indexReservations()
        self.tableView.reloadData()
    }
    
    @IBAction func cancelNewReservation(segue:UIStoryboardSegue) { }
    
    @IBAction func unwindToReservTable(segue: UIStoryboardSegue) { }
    
    @IBAction func unwindSaveToReservTable(segue: UIStoryboardSegue) {
        let index: Int = (self.tableView.indexPathForSelectedRow?.row)!
        let section: Int = (self.tableView.indexPathForSelectedRow?.section)!
        clientAnimals[section].animals[index] = editReservation
        tableView.reloadData()
    }
    
    func indexReservations() {
        for contact in clients {
            for client in contact.clients {
                for a in client.getAnimals() {
                    clientAnimals.append(ReservationContact(date: a.getDMY(d: a.getReservation().dateIn), animals: [a]))
                }
            }
        }
        
        
        dates = {
            return clientAnimals.map { $0.date }
        }()
        dates.sort()
        clientAnimals = clientAnimals.sorted { (a1 , a2) -> Bool in
            a1.date < a2.date
        }
    }
    
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
        filteredAnimals.removeAll()
        for animal in clientAnimals {
            let filteredContent = animal.animals.filter {$0.name.range(of: searchController.searchBar.text!, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }
            if !filteredContent.isEmpty {
                filteredAnimals = filteredContent
            }
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            clientAnimals[indexPath.section].animals.remove(at: indexPath.row)
            if clientAnimals[indexPath.section].animals.count == 0 {
                clientAnimals.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .fade)
                indexReservations()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "currentReservation":
            guard let currentReservationVC = segue.destination as? CurrentReservationViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCell = sender as? ReservationTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "Empty")")
            }
            
            guard tableView.indexPath(for: selectedCell) != nil else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let index: Int = (self.tableView.indexPathForSelectedRow?.row)!
            let section: Int = (self.tableView.indexPathForSelectedRow?.section)!
            if shouldShowSearchResults {
                currentReservationVC.cur_animal = filteredAnimals[index]
            } else {
                currentReservationVC.cur_animal = clientAnimals[section].animals[index]
            }
        case "newReservation":
            guard let newReservationVC = segue.destination as? NewReservationViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            newReservationVC.clientList = clients
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
    
}
