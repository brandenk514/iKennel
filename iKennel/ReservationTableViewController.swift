//
//  TableViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/24/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class ReservationTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var clients = Client.loadAllClients()
    
    var clientAnimals = [ReservationContact]()
    
    var animals = [Animal]()
    
    var dates: [String] = []
    
    var filteredAnimals = [Animal]()
    var shouldShowSearchResults = false
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexReservations()
        configureSearchController()
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
            cell.animalNames.text = selected.socialToText()
        } else {
            let selected = clientAnimals[indexPath.section].animals[indexPath.row]
            cell.clientName.text = selected.name
            cell.animalNames.text = "Checked In: " + selected.socialToText()
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
    }
    
    @IBAction func cancelNewReservation(segue:UIStoryboardSegue) {
    }
    
    func indexReservations() {
        for contact in clients {
            for client in contact.clients {
                for a in client.getAnimals() {
                    animals.append(a)
                }
            }
        }
        for a in animals {
            var reserv = ReservationContact(date: a.getDMY(d: a.getReservation().dateIn), animals: [a])
            for animal in clientAnimals {
                var tempReserv = ReservationContact(date: a.getDMY(d: a.getReservation().dateIn), animals: [a])
                if animal.date == a.getDMY(d: a.getReservation().dateIn) {
                    tempReserv.add(animal: a)
                }
                reserv = tempReserv
            }
            clientAnimals.append(reserv)
        }
        print(clientAnimals)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "currentReservation" {
            let currentReservationVC = segue.destination as! CurrentReservationViewController
            let index: Int = (self.tableView.indexPathForSelectedRow?.row)!
            let section: Int = (self.tableView.indexPathForSelectedRow?.section)!
            if shouldShowSearchResults {
                currentReservationVC.cur_animal = filteredAnimals[index]
            } else {
                currentReservationVC.cur_animal = clientAnimals[section].animals[index]
            }
            
        }
    }
    
}
